defmodule EsCqrsAnatomy.Router do
  @moduledoc false
  use Commanded.Commands.Router

  alias EsCqrsAnatomy.Support.Middlewares.Validate

  alias EsCqrsAnatomy.Order.Aggregate.Order

  alias EsCqrsAnatomy.Order.Commands.{CreateOrder, CompleteOrder}

  middleware Validate
  middleware Commanded.Middleware.Uniqueness

  identify(Order, by: :id)

  dispatch([CreateOrder, CompleteOrder], to: Order)
end
