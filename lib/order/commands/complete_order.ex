defmodule EsCqrsAnatomy.Order.Commands.CompleteOrder do
  @moduledoc false
  use EsCqrsAnatomy.BaseStruct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:blocked_product_ids, list(String.t()), enforce: false)
  end

  validates(:id, presence: true, uuid: true)
end
