defmodule EsCqrsAnatomy.Policies.StreamLinker do
  @moduledoc false
  use Commanded.Event.Handler,
    application: EsCqrsAnatomy.App,
    name: "stream_linker",
    start_from: :origin

  use EsCqrsAnatomy.Base.EventHandler

  alias EsCqrsAnatomy.Order.Events.OrderCompleted
  alias EsCqrsAnatomy.Order.Events.OrderCreated

  def handle(%OrderCreated{}, %{event_id: event_id}) do
    orders_stream_id = UUID.uuid5(:oid, "orders")
    EsCqrsAnatomy.EventStore.link_to_stream(orders_stream_id, :any_version, [event_id])
  end

  def handle(%OrderCompleted{}, %{event_id: event_id}) do
    orders_stream_id = UUID.uuid5(:oid, "orders")
    EsCqrsAnatomy.EventStore.link_to_stream(orders_stream_id, :any_version, [event_id])
  end
end
