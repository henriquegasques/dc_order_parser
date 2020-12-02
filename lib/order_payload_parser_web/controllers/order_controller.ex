defmodule OrderPayloadParserWeb.OrderController do
  use OrderPayloadParserWeb, :controller

  def create(conn, params) do
    parsed_order =
      OrderPayloadParser.parse(params)
      |> OrderPayloadParser.OrderValidationAPIClient.validate_order

    render(conn, "show.json", order: parsed_order)
  end
end
