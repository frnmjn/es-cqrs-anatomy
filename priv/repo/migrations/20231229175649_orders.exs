defmodule EsCqrsAnatomy.Repo.Migrations.Orders do
  use Ecto.Migration

  def change do
     create table(:orders, primary_key: false) do
      add(:id, :string, primary_key: true)
      add(:order_number, :string)
      add(:business_partner, :string)
      add(:status, :string)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:orders, [:order_number]))

    create table(:order_items, primary_key: false) do
      add(:id, :string, primary_key: true)
      add(:order_id, references(:orders, type: :string))
      add(:product_id, :string)
      add(:quantity, :integer)
      add(:uom, :string)

      timestamps(type: :utc_datetime)
    end

  end
end
