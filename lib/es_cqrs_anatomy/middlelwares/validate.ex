defmodule EsCqrsAnatomy.Middleware.Validate do
  @moduledoc false
  @behaviour Commanded.Middleware

  import Commanded.Middleware.Pipeline

  alias Commanded.Middleware.Pipeline

  def before_dispatch(%Pipeline{command: command} = pipeline) do
    if Vex.valid?(command) do
      pipeline
    else
      failed_validation(pipeline)
    end
  end

  def after_dispatch(pipeline), do: pipeline
  def after_failure(pipeline), do: pipeline

  defp failed_validation(%Pipeline{command: command} = pipeline) do
    errors = command |> Vex.errors() |> merge_errors()

    pipeline
    |> respond({:error, :validation_failure, errors})
    |> halt()
  end

  defp merge_errors(errors) do
    errors
    |> Enum.group_by(
      fn {_error, field, _type, _message} -> field end,
      fn {_error, _field, _type, message} -> message end
    )
    |> Map.new()
  end
end
