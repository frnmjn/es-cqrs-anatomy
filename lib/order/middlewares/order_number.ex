alias EsCqrsAnatomy.Order.Projections.Orders
alias EsCqrsAnatomy.Order.Commands.CreateOrder

defimpl Commanded.Middleware.Uniqueness.UniqueFields,
  for: EsCqrsAnatomy.Order.Commands.CreateOrder do
  def unique(%CreateOrder{order_number: order_number}),
    do: [
      {:order_number, "already exist", order_number,
       ignore_case: true, is_unique: &order_number_is_unique?/4, order_number: order_number}
    ]

  def order_number_is_unique?(_field, value, _owner, _opts),
    do: Orders.order_number_is_unique?(value)
end
