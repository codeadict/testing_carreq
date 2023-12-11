defmodule TestingCarreq.HTTP.FinchAdapter do
  @moduledoc """
  Default implementation of `HTTP.ReqAdapter` that uses the default adapter
  of Req (Finch).
  """
  @behaviour TestingCarreq.HTTP.ReqAdapter

  @impl true
  def run(%Req.Request{} = request), do: Req.Steps.run_finch(request)
end
