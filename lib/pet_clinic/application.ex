defmodule PetClinic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PetClinicWeb.Telemetry,
      # Start the Ecto repository
      PetClinic.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PetClinic.PubSub},
      # Start the Endpoint (http/https)
      PetClinicWeb.Endpoint
      # Start a worker by calling: PetClinic.Worker.start_link(arg)
      # {PetClinic.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetClinic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PetClinicWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
