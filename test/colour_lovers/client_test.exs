defmodule TestingCarreq.ColourLovers.ClientTest do
  use ExUnit.Case, async: true
  import Mox

  alias TestingCarreq.ColourLovers.Client

  # Checks your mock expectations on each test
  setup :verify_on_exit!

  test "returns a random colour" do
    expect(TestingCarreq.HTTP.MockAdapter, :run, fn %Req.Request{} = request ->
      {request,
       Req.Response.json(%{
         "description" => "A random colour",
         "hex" => "fff000",
         "imageUrl" => "http://www.colourlovers.com/img/fff000/100/100/watery.png"
       })}
    end)

    assert {:ok, %{status: 200, body: body}} = Client.random_colour()
    assert body["description"] == "A random colour"
  end
end
