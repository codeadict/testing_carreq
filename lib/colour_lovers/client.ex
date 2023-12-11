defmodule TestingCarreq.ColourLovers.Client do
  @moduledoc """
  ColourLovers HTTP client.
  """

  use CarReq,
    base_url: "https://www.colourlovers.com/api/"

  @doc """
  Returns a random color from the API.
  """
  def random_colour do
    [
      url: "colors/random/",
      headers: %{"content-type" => "application/json"},
      method: :get,
      params: %{format: "json"}
    ]
    |> request()
  end

  @impl true
  def client_options do
    [
      adapter: &req_adapter().run/1
    ]
  end

  defp req_adapter do
    :testing_carreq
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:adapter, TestingCarreq.HTTP.FinchAdapter)
  end
end
