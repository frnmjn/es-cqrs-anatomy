defmodule EsCqrsAnatomy.MixProject do
  use Mix.Project

  def project do
    [
      app: :es_cqrs_anatomy,
      version: version(),
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  defp version, do: "0.1.0"

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {EsCqrsAnatomy.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:commanded, "~> 1.2.0"},
      {:commanded_ecto_projections, "~> 1.2"},
      {:commanded_eventstore_adapter, "~> 1.2"},
      {:ecto, "~> 3.6"},
      {:ecto_sql, "~> 3.6"},
      {:eventstore, "~> 1.2"},
      {:jason, "~> 1.2"},
      {:typed_struct, "~> 0.3.0"},
      {:commanded_uniqueness_middleware, "~> 0.7.1"},
      {:vex, "~> 0.9.1"},
      {:exconstructor, "~> 1.2"},
      {:ex_machina, "~> 2.7.0", only: :test},
      {:struct_access, "~> 1.1.2"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:styler, "~> 0.11", only: [:dev, :test], runtime: false},
      {:faker, "~> 0.17.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.create", "ecto.migrate", "event_store.setup"],
      "event_store.setup": ["event_store.create", "event_store.init"],
      "event_store.reset": ["event_store.drop", "event_store.setup"]
    ]
  end

  defp releases do
    [
      escqrsanatomy: [
        version: version(),
        applications: [
          es_cqrs_anatomy: :permanent
        ]
      ]
    ]
  end
end
