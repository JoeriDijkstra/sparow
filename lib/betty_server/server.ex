defmodule Sparow.Betty.Server do
  use GenServer
  alias Sparow.Betty.Worker

  def init(state) do
    IO.puts("Betty server initialized")
    {:ok, state}
  end

  def handle_call(:view, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:write, content}, state) do
    Worker.write(content)
    {:noreply, state}
  end
end
