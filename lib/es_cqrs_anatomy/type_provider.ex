defmodule EsCqrsAnatomy.TypeProvider do
  @moduledoc false

  @behaviour Commanded.EventStore.TypeProvider

  def to_string(struct) do
    struct.__struct__
    |> Atom.to_string()
    |> String.replace("Elixir.EsCqrsAnatomy.", "")
    |> String.replace("Events.", "")
    |> String.replace("Commands.", "")
  end

  def to_struct(type) do
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
