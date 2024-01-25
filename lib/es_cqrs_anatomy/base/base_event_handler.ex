defmodule EsCqrsAnatomy.Base.EventHandler do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      alias Commanded.Event.FailureContext

      require Logger

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
        Process.sleep(1000)
        Map.update(context, :failures, 1, fn failures -> failures + 1 end)
      end
    end
  end
end
