defmodule Sparow.Distributor do
  alias Sparow.Distributor.Worker

  def start_servers(credentials, timer) do
    Worker.start_imap_worker(credentials)
    Worker.start_logging_worker
    Worker.start_cron_worker(timer)
  end

  def stop_servers() do
    Worker.stop_servers()
  end
end
