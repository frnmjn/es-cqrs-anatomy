defmodule EsCqrsAnatomy.Order.Events.OrderCompleted do
  use TypedStruct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
  end
end
