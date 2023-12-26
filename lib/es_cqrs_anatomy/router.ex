defmodule EsCqrsAnatomy.Router do
  use Commanded.Commands.Router

  alias Commanded.Middleware.Uniqueness
  alias EsCqrsAnatomy.Order.Aggregate.Order
  alias EsCqrsAnatomy.Order.Commands.CompleteOrder
  alias EsCqrsAnatomy.Order.Commands.CreateOrder
  alias EsCqrsAnatomy.Shipment.Aggregate.Shipment
  alias EsCqrsAnatomy.Shipment.Commands.CompleteShipment
  alias EsCqrsAnatomy.Shipment.Commands.CreateShipment
  alias EsCqrsAnatomy.Middleware.Enrichment
  alias EsCqrsAnatomy.Middleware.Validate

  middleware(Enrichment)
  middleware(Validate)
  middleware(Uniqueness)

  identify(Order, by: :id)
  identify(Shipment, by: :id)

  dispatch([CreateOrder, CompleteOrder], to: Order)
  dispatch([CreateShipment, CompleteShipment], to: Shipment)
end
