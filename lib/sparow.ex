defmodule Sparow do
  alias Sparow.Distributor

  def init(credentials, timer) do
    Distributor.start_servers(credentials, timer)
  end

  # REMOVE THIS
  def init_test(timer) do
    init({"joeri_dijkstra@outlook.com", "6i%G4D49He@y", "inbox"}, timer)
  end

  def quit() do
    Distributor.stop_servers()
  end
end
