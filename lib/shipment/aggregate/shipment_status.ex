defmodule EsCqrsAnatomy.Shipment.Aggregate.ShipmentStatus do
  @moduledoc false
  def open, do: "OPEN"
  def completed, do: "COMPLETED"
end
