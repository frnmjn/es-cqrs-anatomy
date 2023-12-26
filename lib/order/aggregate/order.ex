defmodule EsCqrsAnatomy.Order.Aggregate.Order do
  @moduledoc false
  use TypedStruct

  alias EsCqrsAnatomy.Order.Aggregate.OrderStatus
  alias EsCqrsAnatomy.Order.Commands.CompleteOrder
  alias EsCqrsAnatomy.Order.Commands.CreateOrder
  alias EsCqrsAnatomy.Order.Commands.DeleteOrder
  alias EsCqrsAnatomy.Order.Events.OrderCompleted
  alias EsCqrsAnatomy.Order.Events.OrderCreated
  alias EsCqrsAnatomy.Order.Events.OrderDeleted

  @derive Jason.Encoder
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
      business_partner: command.business_partner,
      items: command.items
    }
  end

  def execute(%__MODULE__{}, %CreateOrder{}), do: {:error, "Order already created"}

  def execute(%__MODULE__{status: "COMPLETED"}, %CompleteOrder{}),
    do: {:error, "Order already completed"}

  def execute(%__MODULE__{}, %CompleteOrder{blocked_product_ids: blocked_product_ids})
      when length(blocked_product_ids) > 0 do
    {:error, "Order contains blocked products: #{IO.inspect(blocked_product_ids)}"}
  end

  def execute(%__MODULE__{id: id}, %CompleteOrder{}), do: %OrderCompleted{id: id}

  def execute(%__MODULE__{id: id}, %DeleteOrder{}), do: %OrderDeleted{id: id}

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

  def apply(%__MODULE__{} = order, _), do: order
end
