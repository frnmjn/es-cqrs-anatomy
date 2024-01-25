defmodule EsCqrsAnatomy.Shipment.Events.ShipmentCreated do
  @moduledoc false
  use EsCqrsAnatomy.Base.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_id, String.t())
  end
end
