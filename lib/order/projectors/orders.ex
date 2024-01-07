defmodule EsCqrsAnatomy.Order.Projectors.Orders do
  use Commanded.Projections.Ecto,
    application: EsCqrsAnatomy.App,
    repo: EsCqrsAnatomy.Repo,
    name: "orders"

  require Logger

  alias EsCqrsAnatomy.Order.Events.{
    OrderCreated,
    OrderCompleted
  }

  alias EsCqrsAnatomy.Order.Projections.Orders
  alias EsCqrsAnatomy.Order.Projections.OrderItems
  alias EsCqrsAnatomy.Order.Aggregate.OrderStatus

  project(
    %OrderCreated{} = event,
    _metadata,
    fn multi ->
      multi
      |> Ecto.Multi.insert(
        :orders,
        %Orders{
          id: event.id,
          order_number: event.order_number,
          business_partner: event.business_partner,
          status: OrderStatus.open(),
          items:
            event.items
            |> Enum.map(
              &%OrderItems{
                id: UUID.uuid4(),
                order_id: event.id,
                product_id: &1.product_id,
                quantity: &1.quantity,
                uom: &1.uom
              }
            )
        }
      )
    end
  )

  project(
    %OrderCompleted{id: id},
    _metadata,
    fn multi ->
      multi
      |> Ecto.Multi.run(:order_to_update, fn repo, changes ->
        {:ok, repo.get(Orders, id)}
      end)
      |> Ecto.Multi.update(:order, fn %{order_to_update: order} ->
        Ecto.Changeset.change(order,
          status: OrderStatus.completed()
        )
      end)
    end
  )

  def error({:error, error}, event, failure_context) do
    Logger.error(
      "#{__MODULE__} Failed #{inspect(error)}: #{inspect(event)} due to error: #{inspect(failure_context)}"
    )

    :skip
  end
end
