import Config

config :es_cqrs_anatomy, EsCqrsAnatomy.EventStore,
  username: "postgres",
  password: "postgres",
  database: "es_cqrs_anatomy_prod",
  hostname: "postgres"

config :es_cqrs_anatomy, EsCqrsAnatomy.Repo,
  username: "postgres",
  password: "postgres",
  database: "es_cqrs_anatomy_prod",
  hostname: "postgres"
