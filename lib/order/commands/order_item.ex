defmodule EsCqrsAnatomy.Order.Commands.OrderItem do
  @moduledoc false
  use EsCqrsAnatomy.Base.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:product_id, String.t())
    field(:quantity, String.t())
    field(:uom, String.t())
  end

  validates(:product_id, presence: true, uuid: true)
  validates(:quantity, presence: true, number: [greater_than: 0])
  validates(:uom, presence: true, inclusion: ["KG", "MT"])
end
