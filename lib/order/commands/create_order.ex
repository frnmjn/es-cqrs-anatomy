defmodule EsCqrsAnatomy.Order.Commands.CreateOrder do
  use TypedStruct
  use Vex.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_number, String.t())
    field(:business_partner, String.t())
  end

  validates(:id, uuid: true)
  validates(:order_number, presence: true, string: true)
  validates(:business_partner, presence: true, email: true)
end
