defmodule EsCqrsAnatomy.Order.Commands.CompleteOrder do
  use TypedStruct
  use Vex.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:blocked_product_ids, list(String.t()), enforce: false)
  end

  validates(:id, presence: true, uuid: true)
end
