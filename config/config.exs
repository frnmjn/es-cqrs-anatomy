import Config

config :es_cqrs_anatomy,
  ecto_repos: [EsCqrsAnatomy.Repo],
  event_stores: [EsCqrsAnatomy.EventStore]

config :es_cqrs_anatomy, EsCqrsAnatomy.Repo, migration_source: "ecto_migrations"

config :commanded, type_provider: EsCqrsAnatomy.TypeProvider

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
