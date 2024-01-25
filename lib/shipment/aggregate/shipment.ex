defmodule EsCqrsAnatomy.Shipment.Aggregate.Shipment do
  @moduledoc false
  use EsCqrsAnatomy.Base.Struct

  alias EsCqrsAnatomy.Shipment.Aggregate.ShipmentStatus
  alias EsCqrsAnatomy.Shipment.Commands.CompleteShipment
  alias EsCqrsAnatomy.Shipment.Commands.CreateShipment
  alias EsCqrsAnatomy.Shipment.Events.ShipmentCompleted
  alias EsCqrsAnatomy.Shipment.Events.ShipmentCreated

  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_id, String.t())
    field(:status, String.t())
  end

  def execute(%__MODULE__{id: nil}, %CreateShipment{} = command) do
    IO.inspect(%ShipmentCreated{id: command.id, order_id: command.order_id}, label: "EVENT")
  end

  def execute(%__MODULE__{}, %CreateShipment{}), do: {:error, "Shipment already created"}

  def execute(%__MODULE__{status: "COMPLETED"}, %CompleteShipment{}),
    do: {:error, "Shipment already completed"}

  def execute(%__MODULE__{id: id}, %CompleteShipment{}), do: %ShipmentCompleted{id: id}

  def apply(%__MODULE__{} = order, %ShipmentCreated{} = event) do
    %__MODULE__{
      order
      | id: event.id,
        order_id: event.order_id,
        status: ShipmentStatus.open()
    }
  end

  def apply(%__MODULE__{} = order, %ShipmentCompleted{} = event) do
    %__MODULE__{
      order
      | id: event.id,
        status: ShipmentStatus.completed()
    }
  end
end
