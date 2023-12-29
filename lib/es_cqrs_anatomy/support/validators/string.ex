defmodule EsCqrsAnatomy.Support.Validators.String do
  use Vex.Validator

  def validate(nil, _options), do: :ok
  def validate("", _options), do: :ok

  def validate(value, _options) do
    try do
      Vex.Validators.By.validate(value, function: &String.valid?/1)
    rescue
      _ -> {:error, "must be valid string"}
    end
  end
end
