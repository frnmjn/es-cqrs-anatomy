defmodule EsCqrsAnatomy.Order.Projections.Order do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Query

  alias EsCqrsAnatomy.Order.Projections.OrderItem
  alias EsCqrsAnatomy.Repo

  @primary_key {:id, :string, autogenerate: false}
  schema "orders" do
    field(:order_number, :string)
    field(:business_partner, :string)
    field(:status, :string)

    has_many(:items, OrderItem)

    timestamps(type: :utc_datetime)
  end

  def order_number_is_unique?(order_number) do
    Repo.one!(from(o in __MODULE__, select: count("id"), where: o.order_number == ^order_number)) ==
      0
  end

  def first_order_number do
    from(o in __MODULE__, select: o.order_number, order_by: [o.inserted_at])
    |> limit(1)
    |> Repo.all()
  end

  def order_product_ids do
    from(o in __MODULE__, select: o.order_number, order_by: [o.inserted_at])
    |> limit(1)
    |> Repo.all()
  end
end
