alias EsCqrsAnatomy.CommandEnrichment
alias EsCqrsAnatomy.Order.Commands.CompleteOrder
alias EsCqrsAnatomy.Order.Projections.OrderItem
alias EsCqrsAnatomy.Order.Constants

defimpl CommandEnrichment, for: CompleteOrder do
  @doc """
  Enrich command during dispatch, but before aggregate handling.
  """
  def enrich(%CompleteOrder{} = command) do
    %CompleteOrder{id: id} = command

    products_in_order = OrderItem.products_in_order(id)

    command = %CompleteOrder{
      command
      | blocked_product_ids: lookup_external_data(products_in_order)
    }

    {:ok, command}
  end

  defp lookup_external_data(products_in_order) do
    case Enum.member?(products_in_order, Constants.blocked_product_id()) do
      true -> [Constants.blocked_product_id()]
      _ -> []
    end
  end
end
