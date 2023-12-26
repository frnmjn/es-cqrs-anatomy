defmodule EsCqrsAnatomy.Order.Aggregate.OrderStatus do
  @moduledoc false
  def open, do: "OPEN"
  def completed, do: "COMPLETED"
end
