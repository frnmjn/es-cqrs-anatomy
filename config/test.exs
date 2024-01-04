import Config

config :es_cqrs_anatomy, EsCqrsAnatomy.EventStore,
  username: "postgres",
  password: "postgres",
  database: "event_store_test",
  hostname: "localhost"

config :es_cqrs_anatomy, EsCqrsAnatomy.Repo,
  username: "postgres",
  password: "postgres",
  database: "read_store_test",
  hostname: "localhost"
