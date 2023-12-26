defmodule EsCqrsAnatomy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      # Start the Commanded application
      EsCqrsAnatomy.App,

      # Start the Ecto Repo
      EsCqrsAnatomy.Repo,
      # Start all the event handler (Projection and Policy)
      EsCqrsAnatomy.EventHandlerSupervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EsCqrsAnatomy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
