defmodule EsCqrsAnatomy.Order.Events.OrderCreated do
  use TypedStruct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_number, String.t())
    field(:business_partner, String.t())
  end
end
