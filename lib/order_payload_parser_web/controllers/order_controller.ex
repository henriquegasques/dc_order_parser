defmodule OrderPayloadParserWeb.OrderController do
  use OrderPayloadParserWeb, :controller

  def create(conn, params) do
    parsed_order = OrderPayloadParser.parse(params)

    case OrderPayloadParser.OrderValidationAPIClient.validate_order(parsed_order) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        persist_order && render_order(conn, parsed_order)
      {:ok, %HTTPoison.Response{status_code: 400} = response} ->
        render_error(conn, response)
      {:error, %HTTPoison.Error{reason: :timeout}} ->
        retry
    end
  end

  defp render_order(conn, order) do
    render(conn, "show.json", order: order)
  end

  defp render_error(conn, response) do
    conn
    |> put_status(:bad_request)
    |> render("error.json", message: response.body)
  end

  defp persist_order do
    IO.puts "persist"
  end

  def retry do
    IO.puts "retry"
  end
end
