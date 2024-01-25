defprotocol EsCqrsAnatomy.Middleware.Enrichment do
  @doc """
  Enrich a command with additional data during dispatch, before passing to aggregate.
  As an example, this is an extension point where additional data could be retreived
  from the database to enrich the command's fields.
  """
  @fallback_to_any true
  def enrich(command)
end

defmodule EsCqrsAnatomy.Middleware.EnrichCommand do
  @moduledoc false
  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline
  alias EsCqrsAnatomy.Middleware.Enrichment

  @doc """
  Enrich the command via the opt-in command enrichment protocol.
  """
  def before_dispatch(%Pipeline{command: command} = pipeline) do
    case Enrichment.enrich(command) do
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

defimpl EsCqrsAnatomy.Middleware.Enrichment, for: Any do
  @doc """
  By default the command is not modified.
  """
  def enrich(command), do: {:ok, command}
end
