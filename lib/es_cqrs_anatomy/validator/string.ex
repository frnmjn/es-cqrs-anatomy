defmodule EsCqrsAnatomy.Validator.String do
  @moduledoc false
  use Vex.Validator

  def validate(nil, _options), do: :ok
  def validate(value, _options) when is_binary(value), do: :ok

  def validate(_, _options), do: {:error, "must be a valid string"}
end
