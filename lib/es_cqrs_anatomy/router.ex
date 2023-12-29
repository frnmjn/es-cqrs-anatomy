defmodule EsCqrsAnatomy.Router do
  @moduledoc false
  use Commanded.Commands.Router

  alias EsCqrsAnatomy.Order.Aggregate.Order

  alias EsCqrsAnatomy.Order.Commands.{CreateOrder, CompleteOrder}

  identify(Order, by: :id)

  dispatch([CreateOrder, CompleteOrder], to: Order)
end
