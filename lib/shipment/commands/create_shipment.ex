defmodule EsCqrsAnatomy.Shipment.Commands.CreateShipment do
  use TypedStruct
  use Vex.Struct
  use StructAccess

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_id, String.t())
  end

  use ExConstructor

  validates(:id, presence: true, uuid: true)
  validates(:order_id, presence: true, uuid: true)
end
