import Config

config :es_cqrs_anatomy,
  ecto_repos: [EsCqrsAnatomy.Repo],
  event_stores: [EsCqrsAnatomy.EventStore]

config :es_cqrs_anatomy, EsCqrsAnatomy.Repo, migration_source: "ecto_migrations"

config :commanded, type_provider: EsCqrsAnatomy.TypeProvider

config :commanded_uniqueness_middleware,
  adapter: Commanded.Middleware.Uniqueness.Adapter.Cachex,
  # seconds
  ttl: 60,
  use_command_as_partition: false

config :vex,
  sources: [
    EsCqrsAnatomy.Validator,
    Vex.Validators
  ]

config :es_cqrs_anatomy, EsCqrsAnatomy.App,
  snapshotting: %{
    EsCqrsAnatomy.Order.Aggregate.Order => [
      snapshot_every: 1,
      snapshot_version: 1
    ]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
