defmodule EsCqrsAnatomy.Order.Commands.CreateOrder do
  use TypedStruct
  use Vex.Struct
  use StructAccess

  alias EsCqrsAnatomy.Order.Commands.OrderItem

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_number, String.t())
    field(:business_partner, String.t())
    field(:items, list(OrderItem))
  end

  use ExConstructor

  validates(:id, presence: true, uuid: true)
  validates(:order_number, presence: true, string: true)
  validates(:business_partner, presence: true, email: true)
  validates(:items, presence: true, list_of_structs: true)
end
