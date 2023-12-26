defmodule EsCqrsAnatomy.EventHandlerSupervisor do
  @moduledoc false
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    Supervisor.init(
      [
        EsCqrsAnatomy.Order.Projectors.Orders
      ],
      strategy: :one_for_one
    )
  end
end
