# TestingCarreq

Example [ColourLovers](https://www.colourlovers.com/api) API client to show how to test Req / CarReq.

## Testing

Testing HTTP clients can be very tricky, partly because they are software designed to interact with the outside world.

`Req` and thus `CarReq` have the ability to define a lower level adapter to be used for the actual HTTP request. Using a behaviour for such adapter like in [`TestingCarreq.HTTP.ReqAdapter`](lib/http/req_adapter.ex), we can utilize [`Mox`](https://hexdocs.pm/mox/Mox.html) to define a custom `TestingCarreq.HTTP.ReqAdapter` for use only in tests.

First, we need to generate the mock adapter  in `test_helper.exs`:

```elixir
Mox.defmock(TestingCarreq.HTTP.MockAdapter, for: TestingCarreq.HTTP.ReqAdapter)
```

Then configure your `Req`-based client to use this adapter in your config:

```elixir
config :testing_carreq, TestingCarreq.ColourLovers.Client,
  adapter: TestingCarreq.HTTP.MockAdapter
```

Then in your tests, set expectations on the adapter:

```elixir
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
```

### Running  tests

```bash
mix test
```

## Local development adapter

Using the same technique described for testing above, we can also define a Dev adapter to use in development in your local machine without hitting the real API. See [`TestingCarreq.ColourLovers.DevAdapter`](lib/colour_lovers/dev_adapter.ex) for an example.

## Making request

Run `iex -S mix` to make a request to the API:

```bash
iex(1)> alias TestingCarreq.ColourLovers.Client
iex(2)> Client.random_colour()
```

To use the Dev adapter, run iex with `CL_HTTP_ADAPTER="TestingCarreq.ColourLovers.DevAdapter" iex -S mix`.
