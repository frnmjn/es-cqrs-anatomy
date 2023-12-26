defmodule EsCqrsAnatomy.Policies.AggregateDeletion do
  @moduledoc false
  use Commanded.Event.Handler,
    application: EsCqrsAnatomy.App,
    name: "aggregate_deletion",
    start_from: :origin

  alias EsCqrsAnatomy.EventStore
  alias EsCqrsAnatomy.Order.Events.OrderDeleted

  require Logger

  def handle(%OrderDeleted{id: id}, _) do
    expected_version =
      id
      |> EventStore.read_stream_backward()
      |> elem(1)
      |> Enum.count()

    :ok = EventStore.delete_stream(id, expected_version, :hard)
    Logger.info("#{__MODULE__} - Order #{id} deleted")
  end
end
