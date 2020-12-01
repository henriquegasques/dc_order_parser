defmodule OrderPayloadParserWeb.OrderController do
  use OrderPayloadParserWeb, :controller

  def create(conn, params) do
    render(conn, "show.json", order: params)
  end
end
