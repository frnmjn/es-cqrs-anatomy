defmodule EsCqrsAnatomy.Order.Aggregate.Order do
  use TypedStruct

  alias EsCqrsAnatomy.Order.Commands.{CreateOrder, CompleteOrder}
  alias EsCqrsAnatomy.Order.Events.{OrderCreated, OrderCompleted}
  alias EsCqrsAnatomy.Order.Aggregate.OrderStatus

  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_number, String.t())
    field(:business_partner, String.t())
    field(:status, String.t())
  end

  def execute(%__MODULE__{id: nil}, %CreateOrder{} = command) do
    %OrderCreated{
      id: command.id,
      order_number: command.order_number,
      business_partner: command.business_partner
    }
  end

  def execute(%__MODULE__{}, %CreateOrder{}), do: {:error, "Order already created"}

  def execute(%__MODULE__{status: "COMPLETED"}, %CompleteOrder{}),
    do: {:error, "Order already completed"}

  def execute(%__MODULE__{id: id}, %CompleteOrder{}) do
    %OrderCompleted{
      id: id
    }
  end

  def apply(%__MODULE__{} = order, %OrderCreated{} = event) do
    %__MODULE__{
      order
      | id: event.id,
        order_number: event.order_number,
        business_partner: event.business_partner,
        status: OrderStatus.open()
    }
  end

  def apply(%__MODULE__{} = order, %OrderCompleted{} = event) do
    %__MODULE__{
      order
      | id: event.id,
        status: OrderStatus.completed()
    }
  end
end
