defmodule EsCqrsAnatomy.Base.Struct do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      use TypedStruct
      use Vex.Struct
      use StructAccess
      use ExConstructor

      def build(input) do
        with {:ok, command} <- {:ok, __MODULE__.new(input)},
             {:errors, []} <- {:errors, Vex.errors(command)} do
          command
        else
          {:errors, errors} -> {:error, errors}
          _ -> {:error, "Error during the struct construction with #{input}"}
        end
      end
    end
  end
end
