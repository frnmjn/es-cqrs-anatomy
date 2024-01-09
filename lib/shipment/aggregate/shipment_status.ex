defmodule EsCqrsAnatomy.Shipment.Aggregate.ShipmentStatus do
  def open, do: "OPEN"
  def completed, do: "COMPLETED"
end
