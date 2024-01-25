alias EsCqrsAnatomy.Middleware.Enrichment.EnrichmentProtocol
alias EsCqrsAnatomy.Order.Commands.CompleteOrder
alias EsCqrsAnatomy.Order.Constants
alias EsCqrsAnatomy.Order.Projections.OrderItem

defimpl EnrichmentProtocol, for: CompleteOrder do
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
    if Enum.member?(products_in_order, Constants.blocked_product_id()) do
      [Constants.blocked_product_id()]
    else
      []
    end
  end
end
