defmodule EsCqrsAnatomy.OrderFactory do
  @moduledoc false
  use ExMachina

  alias EsCqrsAnatomy.Order.Commands.CreateOrder
  alias EsCqrsAnatomy.Order.Commands.OrderItem

  def create_order_factory do
    %CreateOrder{
      id: UUID.uuid4(),
      order_number: "00001",
      business_partner: "jane.doe@acme.com",
      items: [
        %OrderItem{
          product_id: UUID.uuid4(),
          quantity: 1,
          uom: "KG"
        }
      ]
    }
  end
end
