defmodule EsCqrsAnatomy.Repo do
  use Ecto.Repo,
    otp_app: :es_cqrs_anatomy,
    adapter: Ecto.Adapters.Postgres

  # Optional `init/2` function to modify config at runtime.
  def init(_type, config) do
    {:ok, config}
  end
end
