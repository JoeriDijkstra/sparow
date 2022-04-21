defmodule Sparow.Betty.Worker do
  @endpoint_url "https://sparow.bettywebblocks.com/create_log"

  def write(content) do
    {:ok, req_body} = Jason.encode(%{"log_entry" => content})
    HTTPoison.post(@endpoint_url, req_body, %{"Content-Type" => "application/json"})
  end
end
