defmodule Sparow do
  alias Sparow.Distributor

  def init(credentials, timer \\ 60000) do
    Distributor.start_servers(credentials, timer)
  end

  def init_test(timer \\ 60000) do
     init({"joeri_dijkstra@outlook.com", "6i%G4D49He@y", "inbox"} , timer)
  end

  def quit() do
    Distributor.stop_servers()
  end
end
