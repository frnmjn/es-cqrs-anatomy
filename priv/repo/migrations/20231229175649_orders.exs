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
  end
end
