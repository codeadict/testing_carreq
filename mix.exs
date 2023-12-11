defmodule TestingCarreq.MixProject do
  use Mix.Project

  def project do
    [
      app: :testing_carreq,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:car_req, github: "carsdotcom/car_req", tag: "0.2.2"},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
