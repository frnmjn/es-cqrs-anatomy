defmodule EsCqrsAnatomy.Support.Validators.Struct do
  use Vex.Validator

  def validate(value, _options) when is_struct(value) do
    errors =
      value
      |> Vex.errors()

    if(Enum.empty?(errors)) do
      :ok
    else
      {:error, errors}
    end
  end

  def validate(_, _options), do: {:error, "must be a valid struct"}
end
