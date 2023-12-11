defmodule TestingCarreq.ColourLovers.DevAdapter do
  alias Req.{Request, Response}
  @behaviour TestingCarreq.HTTP.ReqAdapter

  @impl true
  def run(%Request{url: %URI{path: "/api/colors/random/"}} = request) do
    {request, random_endpoint_response()}
  end

  defp random_endpoint_response() do
    Response.json(%{
      "description" => "Local development colour, always the same",
      "hex" => "000000",
      "imageUrl" => "http://www.colourlovers.com/img/000000/100/100/watery.png"
    })
  end
end
