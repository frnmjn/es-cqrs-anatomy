defmodule EsCqrsAnatomy.Shipment.Events.ShipmentCreated do
  use TypedStruct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_id, String.t())
  end
end
