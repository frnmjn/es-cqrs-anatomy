defmodule EsCqrsAnatomy.Order.Projections.Orders do
  use Ecto.Schema

  import Ecto.Query

  alias EsCqrsAnatomy.Repo

  @primary_key {:id, :string, autogenerate: false}
  schema "orders" do
    field(:order_number, :string)
    field(:business_partner, :string)
    field(:status, :string)

    timestamps(type: :utc_datetime)
  end

  def order_number_is_unique?(order_number) do
    from(o in __MODULE__, select: count("id"), where: o.order_number == ^order_number)
    |> Repo.one!() == 0
  end
end
