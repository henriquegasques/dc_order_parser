defmodule OrderPayloadParser.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OrderPayloadParser.Repo,
      # Start the Telemetry supervisor
      OrderPayloadParserWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OrderPayloadParser.PubSub},
      # Start the Endpoint (http/https)
      OrderPayloadParserWeb.Endpoint
      # Start a worker by calling: OrderPayloadParser.Worker.start_link(arg)
      # {OrderPayloadParser.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OrderPayloadParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OrderPayloadParserWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
