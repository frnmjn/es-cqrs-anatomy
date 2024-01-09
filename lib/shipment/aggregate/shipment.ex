defmodule EsCqrsAnatomy.Shipment.Aggregate.Shipment do
  use TypedStruct

  alias EsCqrsAnatomy.Shipment.Commands.{CreateShipment, CompleteShipment}
  alias EsCqrsAnatomy.Shipment.Events.{ShipmentCreated, ShipmentCompleted}
  alias EsCqrsAnatomy.Shipment.Aggregate.ShipmentStatus

  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_id, String.t())
    field(:status, String.t())
  end

  def execute(%__MODULE__{id: nil}, %CreateShipment{} = command) do
    %ShipmentCreated{
      id: command.id,
      order_id: command.order_id
    }
    |> IO.inspect(label: "EVENT")
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
