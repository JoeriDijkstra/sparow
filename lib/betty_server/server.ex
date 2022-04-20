defmodule Sparow.Betty.Server do
  use GenServer

  def init(state) do
    IO.puts("Betty server initialized")
    {:ok, state}
  end

  def handle_call(:view, _from, state) do
    {:reply, state, state}
  end
end
