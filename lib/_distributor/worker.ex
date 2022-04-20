defmodule Sparow.Distributor.Worker do
  alias Sparow.{IMAP, Logging, CronServer}
  @imap_worker :imap_server
  @logging_worker :logging_server
  @cron_worker :cron_server

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

  def stop_servers do
    GenServer.stop(@imap_worker)
    GenServer.stop(@logging_worker)
    GenServer.stop(@cron_worker)
  end
end
