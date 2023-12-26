defmodule EsCqrsAnatomy.Shipment.Policies.Shipment do
  @moduledoc false
  use Commanded.Event.Handler,
    application: EsCqrsAnatomy.App,
    name: "shipment",
    start_from: :current

  use EsCqrsAnatomy.Base.EventHandler

  alias EsCqrsAnatomy.Order.Events.OrderCompleted
  alias EsCqrsAnatomy.Shipment.Commands.CreateShipment

  require Logger

  def handle(%OrderCompleted{id: id}, %{event_id: causation_id, correlation_id: correlation_id}) do
    EsCqrsAnatomy.App.dispatch(%CreateShipment{id: UUID.uuid4(), order_id: id},
      causation_id: causation_id,
      correlation_id: correlation_id
    )
  end
end
