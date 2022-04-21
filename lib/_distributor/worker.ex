defmodule Sparow.Distributor.Worker do
  alias Sparow.{IMAP, Logging, CronServer, Betty}
  @imap_worker :imap_server
  @logging_worker :logging_server
  @cron_worker :cron_server
  @betty_worker :betty_server

  def start_logging_worker do
    GenServer.start_link(Logging.Server, [], name: @logging_worker)
  end

  def start_cron_worker(timer) do
    GenServer.start_link(CronServer.Server, timer, name: @cron_worker)
  end

  def start_imap_worker(credentials) do
    {email, password, inbox} = credentials
    GenServer.start_link(IMAP.Server, %{inbox: inbox, email: email, password: password}, name: @imap_worker)
  end

  def start_betty_worker do
    GenServer.start_link(Betty.Server, [], name: @betty_worker)
  end

  def stop_servers do
    # Log exit of server
    now = to_string(NaiveDateTime.utc_now())
    GenServer.call(@logging_worker, {:log, "Server quited at #{now}"})

    # Stop all servers
    GenServer.stop(@imap_worker)
    GenServer.stop(@logging_worker)
    GenServer.stop(@cron_worker)
    GenServer.stop(@betty_worker)

    IO.puts("Servers have been stopped, log has been created -> #{now}")
  end
end
