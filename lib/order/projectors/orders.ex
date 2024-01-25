defmodule EsCqrsAnatomy.Order.Projectors.Orders do
  @moduledoc false
  use Commanded.Projections.Ecto,
    application: EsCqrsAnatomy.App,
    repo: EsCqrsAnatomy.Repo,
    name: "orders"

  use EsCqrsAnatomy.Base.EventHandler

  alias EsCqrsAnatomy.Order.Aggregate.OrderStatus
  alias EsCqrsAnatomy.Order.Events.OrderCompleted
  alias EsCqrsAnatomy.Order.Events.OrderCreated
  alias EsCqrsAnatomy.Order.Events.OrderDeleted
  alias EsCqrsAnatomy.Order.Projections.Order
  alias EsCqrsAnatomy.Order.Projections.OrderItem

  require Logger

  project(
    %OrderCreated{} = event,
    _metadata,
    fn multi ->
      Ecto.Multi.insert(multi, :orders, %Order{
        id: event.id,
        order_number: event.order_number,
        business_partner: event.business_partner,
        status: OrderStatus.open(),
        items:
          Enum.map(
            event.items,
            &%OrderItem{
              id: UUID.uuid4(),
              order_id: event.id,
              product_id: &1.product_id,
              quantity: &1.quantity,
              uom: &1.uom
            }
          )
      })
    end
  )

  project(
    %OrderCompleted{id: id},
    _metadata,
    fn multi ->
      multi
      |> Ecto.Multi.run(:order_to_update, fn repo, _changes ->
        {:ok, repo.get(Order, id)}
      end)
      |> Ecto.Multi.update(:order, fn %{order_to_update: order} ->
        Ecto.Changeset.change(order,
          status: OrderStatus.completed()
        )
      end)
    end
  )

  project(
    %OrderDeleted{id: id},
    _metadata,
    fn multi ->
      Ecto.Multi.run(multi, :order_to_delete, fn repo, _changes ->
        {rows_deleted, _} = repo.delete_all(from(o in Order, where: o.id == ^id))
        {:ok, rows_deleted}
      end)
    end
  )
end
