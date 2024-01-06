defmodule EsCqrsAnatomy.Order.Commands.CreateOrderTest do
  use ExUnit.Case

  import Access
  import EsCqrsAnatomy.Support.OrderFactory

  test "build a createOrder command" do
    assert true ==
             build(:create_order)
             |> Vex.valid?()
  end

  test "order_number should be present" do
    assert [{:error, :order_number, :presence, "must be present"}] =
             build(:create_order)
             |> put_in([:order_number], nil)
             |> Vex.errors()
  end

  test "order_number should be valid" do
    assert [{:error, :order_number, :string, "must be a valid string"}] =
             build(:create_order)
             |> put_in([:order_number], 1)
             |> Vex.errors()
  end

  test "business_partner should be valid" do
    assert [{:error, :business_partner, :email, "must be a valid email"}] =
             build(:create_order)
             |> put_in([:business_partner], "a@b")
             |> Vex.errors()
  end

  test "invalid items list" do
    assert [{:error, :items, :presence, "must be present"}] =
             build(:create_order)
             |> put_in([:items], [])
             |> Vex.errors()
  end

  test "invalid item qty" do
    assert [
             {:error, :items, :list_of_structs,
              [{0, [{:error, :quantity, :number, "must be a number greater than 0"}]}]}
           ] =
             build(:create_order)
             |> put_in([:items, at(0), :quantity], 0)
             |> Vex.errors()
  end
end
