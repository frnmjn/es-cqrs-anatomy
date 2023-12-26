import Config

config :es_cqrs_anatomy, EsCqrsAnatomy.EventStore,
  username: "postgres",
  password: "postgres",
  database: "event_store",
  hostname: "postgres"

config :es_cqrs_anatomy, EsCqrsAnatomy.Repo,
  username: "postgres",
  password: "postgres",
  database: "read_store",
  hostname: "postgres"

config :logger,
  level: :error
