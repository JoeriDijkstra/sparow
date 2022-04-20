defmodule Sparow.Logging.Server do
  use GenServer
  alias Sparow.Logging.Worker

  def init(state) do
    IO.puts("Logging server initialized")
    {:ok, state}
  end

  def handle_call(:view, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:log, log}, _from, state) do
    response = Worker.log_to_file(log)
    {:reply, response, state}
  end
end
