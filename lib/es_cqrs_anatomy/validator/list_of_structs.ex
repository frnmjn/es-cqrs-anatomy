defmodule EsCqrsAnatomy.Validator.ListOfStructs do
  @moduledoc false
  use Vex.Validator

  def validate(value, _options) when is_list(value) do
    errors =
      value
      |> Enum.with_index()
      |> Enum.map(fn {item, index} ->
        {index, Vex.errors(item)}
      end)
      |> Enum.filter(&(elem(&1, 1) != []))

    if(Enum.empty?(errors)) do
      :ok
    else
      {:error, errors}
    end
  end

  def validate(_, _options), do: {:error, "must be a valid list"}
end
