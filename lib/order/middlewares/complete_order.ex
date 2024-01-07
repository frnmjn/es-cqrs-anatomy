alias EsCqrsAnatomy.CommandEnrichment
alias EsCqrsAnatomy.Order.Commands.CompleteOrder

defimpl CommandEnrichment, for: CompleteOrder do
  @doc """
  Enrich command during dispatch, but before aggregate handling.
  """
  def enrich(%CompleteOrder{} = command) do
    %CompleteOrder{id: id} = command

    command = %CompleteOrder{
      command
      | blocked_product_ids: lookup_external_data(id)
    }

    {:ok, command}
  end

  defp lookup_external_data(_), do: []
end
