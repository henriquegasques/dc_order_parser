defmodule OrderPayloadParser.Repo do
  use Ecto.Repo,
    otp_app: :order_payload_parser,
    adapter: Ecto.Adapters.Postgres
end
