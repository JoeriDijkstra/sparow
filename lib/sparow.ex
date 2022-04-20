defmodule Sparow do
  alias Sparow.Distributor

  def init(credentials, timer) do
    Distributor.start_servers(credentials, timer)
  end

  def quit() do
    Distributor.stop_servers()
  end
end
