defprotocol EsCqrsAnatomy.CommandEnrichment do
  @doc """
  Enrich a command with additional data during dispatch, before passing to aggregate.
  As an example, this is an extension point where additional data could be retreived
  from the database to enrich the command's fields.
  """
  @fallback_to_any true
  def enrich(command)
end

defimpl EsCqrsAnatomy.CommandEnrichment, for: Any do
  @doc """
  By default the command is not modified.
  """
  def enrich(command), do: {:ok, command}
end
