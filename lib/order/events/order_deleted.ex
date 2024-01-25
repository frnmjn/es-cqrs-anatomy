defmodule EsCqrsAnatomy.Order.Events.OrderDeleted do
  @moduledoc false
  use EsCqrsAnatomy.Base.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
  end
end
