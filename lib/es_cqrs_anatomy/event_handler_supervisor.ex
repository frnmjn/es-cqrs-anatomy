defmodule EsCqrsAnatomy.EventHandlerSupervisor do
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    Supervisor.init(
      [
        EsCqrsAnatomy.Order.Projectors.Orders,
        EsCqrsAnatomy.Shipment.Policies.Shipment
      ],
      strategy: :one_for_one
    )
  end
end
