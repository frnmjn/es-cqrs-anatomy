defmodule EsCqrsAnatomy.Validator.Email do
  @moduledoc false
  use Vex.Validator

  def validate(value, _options) when is_binary(value) do
    if String.match?(value, regexp()) do
      :ok
    else
      {:error, "must be a valid email"}
    end
  end

  def validate(_, _options), do: {:error, "must be a valid email"}

  defp regexp,
    do: ~r/^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$/
end
