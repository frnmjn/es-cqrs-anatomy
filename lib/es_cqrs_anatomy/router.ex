defmodule EsCqrsAnatomy.Router do
  use Commanded.Commands.Router

  alias EsCqrsAnatomy.Support.Middlewares.{Validate, Enrich}
  alias Commanded.Middleware.Uniqueness
  alias EsCqrsAnatomy.Order.Aggregate.Order
  alias EsCqrsAnatomy.Order.Commands.{CreateOrder, CompleteOrder}
  alias EsCqrsAnatomy.Shipment.Aggregate.Shipment
  alias EsCqrsAnatomy.Shipment.Commands.{CreateShipment, CompleteShipment}

  middleware Enrich
  middleware Validate
  middleware Uniqueness

  identify(Order, by: :id)
  identify(Shipment, by: :id)

  dispatch([CreateOrder, CompleteOrder], to: Order)
  dispatch([CreateShipment, CompleteShipment], to: Shipment)
end
