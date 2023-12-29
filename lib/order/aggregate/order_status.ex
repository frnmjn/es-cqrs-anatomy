defmodule EsCqrsAnatomy.Order.Aggregate.OrderStatus do
  def open, do: "OPEN"
  def completed, do: "COMPLETED"
end
