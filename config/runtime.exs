import Config

import TestingCarreq.ConfigHelpers, only: [get_env: 3]

if config_env() == :test do
  config :testing_carreq, TestingCarreq.ColourLovers.Client,
    adapter: TestingCarreq.HTTP.MockAdapter
else
  config :testing_carreq, TestingCarreq.ColourLovers.Client,
    adapter: get_env("CL_HTTP_ADAPTER", :elixir_module, TestingCarreq.HTTP.FinchAdapter)
end
