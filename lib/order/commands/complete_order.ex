defmodule EsCqrsAnatomy.Order.Commands.CompleteOrder do
  use TypedStruct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
  end
end
