defmodule EsCqrsAnatomy.Order.Projections.OrderItem do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Query

  alias EsCqrsAnatomy.Order.Projections.Order
  alias EsCqrsAnatomy.Repo

  @primary_key {:id, :string, autogenerate: false}
  schema "order_items" do
    field(:order_id, :string)
    field(:product_id, :string)
    field(:quantity, :integer)
    field(:uom, :string)

    belongs_to(:order, Order, foreign_key: :oder_id)

    timestamps(type: :utc_datetime)
  end

  def products_in_order(order_id) do
    Repo.all(from(oi in __MODULE__, select: oi.product_id, where: oi.order_id == ^order_id))
  end
end
