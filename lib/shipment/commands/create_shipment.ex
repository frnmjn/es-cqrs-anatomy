defmodule EsCqrsAnatomy.Shipment.Commands.CreateShipment do
  @moduledoc false
  use EsCqrsAnatomy.Base.Struct

  @derive Jason.Encoder
  typedstruct enforce: true do
    field(:id, String.t())
    field(:order_id, String.t())
  end

  validates(:id, presence: true, uuid: true)
  validates(:order_id, presence: true, uuid: true)
end
