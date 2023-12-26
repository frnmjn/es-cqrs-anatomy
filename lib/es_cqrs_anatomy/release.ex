defmodule EsCqrsAnatomy.Release do
  require Logger

  alias Ecto.Migrator

  @app :es_cqrs_anatomy

  def init do
    Logger.info("Star release  init")
    load_app!()
    init_event_store()
    migrate_repos()
    Logger.info("End release  init")
  end

  defp load_app!(), do: :ok = Application.ensure_loaded(@app)

  defp init_event_store() do
    config = EsCqrsAnatomy.EventStore.config()
    :ok = EventStore.Tasks.Create.exec(config, [])
    :ok = EventStore.Tasks.Init.exec(config, [])
  end


  defp migrate_repos() do
    repos = Application.fetch_env!(@app, :ecto_repos)

    for repo <- repos do
      migrate(repo)
    end
  end

  @spec migrate(Ecto.Repo.t()) :: {:ok, [String.t()]} | {:error, any()}
  def migrate(repo) do
    case Migrator.with_repo(repo, &Migrator.run(&1, :up, all: true)) do
      {:ok, [], _} ->
        Logger.info("No migrations to run", repo: repo)
        {:ok, []}

      {:ok, migrations, _} ->
        Logger.info("Correctly run migrations", repo: repo, migrations: migrations)
        {:ok, migrations}

      {:error, error} ->
        Logger.error("Error running migrations", repo: repo, error: error)
        {:error, error}
    end
  end

end
