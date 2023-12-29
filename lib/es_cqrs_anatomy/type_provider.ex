defmodule EsCqrsAnatomy.TypeProvider do
  @moduledoc false

  @behaviour EsCqrsAnatomy.EventStore.TypeProvider

  @impl Commanded.EventStore.TypeProvider
  def to_string(struct) do
    IO.inspect("0000000000000000000000")

    struct.__struct__
    |> Atom.to_string()
    |> String.replace("Elixir.EsCqrsAnatomy.", "")
    |> String.replace("Events.", "")
    |> String.replace("Commands.", "")
  end

  @impl Commanded.EventStore.TypeProvider
  def to_struct(type) do
    IO.inspect("1111111111111111111111")

    if String.starts_with?(type, "Elixir") do
      type
      |> String.to_atom()
      |> struct()
    else
      [aggregate, event] = String.split(type, ".")

      "Elixir.EsCqrsAnatomy.#{aggregate}.Events.#{event}"
      |> String.to_atom()
      |> struct()
    end
  end
end
