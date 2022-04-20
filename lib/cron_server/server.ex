defmodule Sparow.CronServer.Server do
  use GenServer
  alias Sparow.CronServer.Worker

  def init(state) do
    IO.puts("Cron server initialized")
    :timer.send_interval(state, :work)
    {:ok, state}
  end

  def handle_info(:work, state) do
    Worker.start_pipeline
    {:noreply, state}
  end

  def handle_call(:view, _from, state) do
    {:reply, state, state}
  end
end
