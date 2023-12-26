defmodule EsCqrsAnatomy.Order.Events.OrderDeleted do
  @moduledoc false
  use EsCqrsAnatomy.BaseStruct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
  end
end
