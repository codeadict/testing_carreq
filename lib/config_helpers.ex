defmodule TestingCarreq.ConfigHelpers do
  @type config_type :: :elixir_module

  @spec get_env(String.t(), config_type(), any()) :: any()
  def get_env(var, type, default \\ nil) do
    case System.fetch_env(var) do
      {:ok, val} ->
        cast(val, type)

      _ ->
        default
    end
  end

  defp cast(value, :elixir_module) do
    if String.starts_with?(value, "Elixir.") do
      String.to_existing_atom(value)
    else
      String.to_existing_atom("Elixir." <> value)
    end
  end
end
