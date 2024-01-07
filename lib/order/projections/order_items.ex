defmodule EsCqrsAnatomy.Order.Projections.OrderItems do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  schema "order_items" do
    field(:order_id, :string)
    field(:product_id, :string)
    field(:quantity, :integer)
    field(:uom, :string)

    timestamps(type: :utc_datetime)
  end
end
