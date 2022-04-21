defmodule Sparow do
  alias Sparow.Distributor

  def init(credentials, timer \\ 60000) do
    Distributor.start_servers(credentials, timer)
  end

  def quit() do
    Distributor.stop_servers()
  end
end
