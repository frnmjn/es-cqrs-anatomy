defmodule EsCqrsAnatomy.Validator.Struct do
  @moduledoc false
  use Vex.Validator

  def validate(value, _options) when is_struct(value) do
    errors =
      Vex.errors(value)

    if(Enum.empty?(errors)) do
      :ok
    else
      {:error, errors}
    end
  end

  def validate(_, _options), do: {:error, "must be a valid struct"}
end
