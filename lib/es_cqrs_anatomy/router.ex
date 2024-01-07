defmodule EsCqrsAnatomy.Router do
  use Commanded.Commands.Router

  alias EsCqrsAnatomy.Support.Middlewares.{Validate, Enrich}
  alias Commanded.Middleware.Uniqueness
  alias EsCqrsAnatomy.Order.Aggregate.Order
  alias EsCqrsAnatomy.Order.Commands.{CreateOrder, CompleteOrder}

  middleware Enrich
  middleware Validate
  middleware Uniqueness

  identify(Order, by: :id)

  dispatch([CreateOrder, CompleteOrder], to: Order)
end
