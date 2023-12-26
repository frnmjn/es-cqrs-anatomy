defmodule EsCqrsAnatomy.Order.Events.OrderCreated do
  @moduledoc false
  use EsCqrsAnatomy.BaseStruct

  alias EsCqrsAnatomy.Order.Commands.OrderItem

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_number, String.t())
    field(:business_partner, String.t())
    field(:items, list(OrderItem))
  end
end
