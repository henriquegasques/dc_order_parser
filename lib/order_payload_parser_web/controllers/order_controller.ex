defmodule OrderPayloadParserWeb.OrderController do
  use OrderPayloadParserWeb, :controller

  def create(conn, params) do
    parsed_order = OrderPayloadParser.parse(params)

    case OrderPayloadParser.OrderValidationAPIClient.validate_order do
      {:ok, %HTTPoison.Response{status_code: 200}} -> persist_order
      {:error, %HTTPoison.Error{reason: :timeout}} -> retry
    end

    render(conn, "show.json", order: parsed_order)
  end
end
