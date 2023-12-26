alias EsCqrsAnatomy.Order.Commands.CreateOrder
alias EsCqrsAnatomy.Order.Projections.Order

defimpl Commanded.Middleware.Uniqueness.UniqueFields,
  for: EsCqrsAnatomy.Order.Commands.CreateOrder do
  def unique(%CreateOrder{order_number: order_number}),
    do: [
      {:order_number, "already exist", order_number,
       ignore_case: false, is_unique: &order_number_is_unique?/4, order_number: order_number}
    ]

  def order_number_is_unique?(_field, value, _owner, _opts),
    do: Order.order_number_is_unique?(value)
end
