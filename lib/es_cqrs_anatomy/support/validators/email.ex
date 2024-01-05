defmodule EsCqrsAnatomy.Support.Validators.Email do
  use Vex.Validator

  def validate(value, _options) do
    Vex.Validators.By.validate(value,
      function: &valid_email?/1,
      allow_nil: false,
      allow_blank: false
    )
  end

  def valid_email?(value) do
    case EmailChecker.valid?(value) do
      true -> :ok
      _ -> {:error, "must be valid email"}
    end
  end

  defp regexp(),
    do: ~r/^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$/
end
