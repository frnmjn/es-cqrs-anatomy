defmodule EsCqrsAnatomy.App do
  @moduledoc false

  use Commanded.Application,
    otp_app: :es_cqrs_anatomy,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: EsCqrsAnatomy.EventStore
    ]

  router(EsCqrsAnatomy.Router)
end
