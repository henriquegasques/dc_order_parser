defmodule OrderPayloadParserWeb.OrderController do
  use OrderPayloadParserWeb, :controller

  def create(conn, params) do
    parsed_order = OrderPayloadParser.Parser.parse(params)

    case perform_validation_request(parsed_order) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        OrderPayloadParser.Orders.create_order(parsed_order)
        render(conn, "show.json", order: parsed_order)

      {:ok, %HTTPoison.Response{status_code: 400} = response} ->
        render_error(conn, response)

      {:error, _response} ->
        conn
        |> put_status(503)
        |> json(%{error: :timeout})
    end
  end

  defp perform_validation_request(order, retry \\ 3)
  defp perform_validation_request(_order, _retry = 0), do: {:error, "timeout"}
  defp perform_validation_request(order, retry) do
    case OrderPayloadParser.OrderValidationAPIClient.validate_order(order) do
      {:error, %HTTPoison.Error{reason: :timeout}} -> perform_validation_request(order, retry - 1)
      {:ok, response} -> {:ok, response}
    end
  end

  defp render_error(conn, response) do
    conn
    |> put_status(:bad_request)
    |> render("error.json", message: response.body)
  end
end
