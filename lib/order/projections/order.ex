defmodule EsCqrsAnatomy.Order.Projections.Orders do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  schema "orders" do
    field(:order_number, :string)
    field(:business_partner, :string)
    field(:status, :string)

    timestamps(type: :utc_datetime)
  end
end
