defmodule EsCqrsAnatomy.Shipment.Policies.Shipment do
  use Commanded.Event.Handler,
    application: EsCqrsAnatomy.App,
    name: "shipment",
    start_from: :current

  require Logger

  alias Commanded.Event.FailureContext
  alias EsCqrsAnatomy.Order.Events.OrderCompleted
  alias EsCqrsAnatomy.Shipment.Commands.CreateShipment

  def handle(%OrderCompleted{id: id}, %{
        event_id: causation_id,
        correlation_id: correlation_id
      }) do
    %CreateShipment{
      id: UUID.uuid4(),
      order_id: id
    }
    |> EsCqrsAnatomy.App.dispatch(causation_id: causation_id, correlation_id: correlation_id)
  end

  def error({:error, reason}, event, %FailureContext{context: context}) do
    context = record_failure(context)

    case Map.get(context, :failures) do
      too_many when too_many >= 3 ->
        # skip bad event after third failure
        Logger.error(
          "#{__MODULE__} Skipping bad event, too many failures: #{inspect(event)} for reason: #{inspect(reason)}"
        )

        :skip

      _ ->
        # retry event, failure count is included in context map
        {:retry, context}
    end
  end

  defp record_failure(context) do
    Map.update(context, :failures, 1, fn failures -> failures + 1 end)
  end
end
