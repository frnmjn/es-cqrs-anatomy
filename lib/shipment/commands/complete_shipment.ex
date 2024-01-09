defmodule EsCqrsAnatomy.Shipment.Commands.CompleteShipment do
  use TypedStruct
  use Vex.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
  end

  validates(:id, presence: true, uuid: true)
end
