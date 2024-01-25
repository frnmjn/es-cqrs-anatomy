defmodule EsCqrsAnatomy.Middleware.Enrichment do
  @moduledoc false
  @behaviour Commanded.Middleware
  alias Commanded.Middleware.Pipeline
  alias EsCqrsAnatomy.Middleware.Enrichment.EnrichmentProtocol

  defprotocol EnrichmentProtocol do
    @doc """
    Enrich a command with additional data during dispatch, before passing to aggregate.
    As an example, this is an extension point where additional data could be retreived
    from the database to enrich the command's fields.
    """
    @fallback_to_any true
    def enrich(command)
  end

  @doc """
  Enrich the command via the opt-in command enrichment protocol.
  """
  def before_dispatch(%Pipeline{command: command} = pipeline) do
    case EnrichmentProtocol.enrich(command) do
      {:ok, command} ->
        %Pipeline{pipeline | command: command}

      {:error, _error} = reply ->
        pipeline
        |> Pipeline.respond(reply)
        |> Pipeline.halt()
    end
  end

  def after_dispatch(pipeline), do: pipeline

  def after_failure(pipeline), do: pipeline
end

defimpl EsCqrsAnatomy.Middleware.Enrichment.EnrichmentProtocol, for: Any do
  @doc """
  By default the command is not modified.
  """
  def enrich(command), do: {:ok, command}
end
