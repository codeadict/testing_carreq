defmodule TestingCarreq.HTTP.ReqAdapter do
  @moduledoc """
  Defines a behaviour for a Req adapter to allow mocking requests with Mox or Hammox.
  """
  @callback run(Req.Request.t()) ::
              {Req.Request.t(), Req.Response.t() | Exception.t()}
end
