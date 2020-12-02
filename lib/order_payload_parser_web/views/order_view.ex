defmodule OrderPayloadParserWeb.OrderView do
  use OrderPayloadParserWeb, :view

  def render("show.json", %{order: order_payload}) do
    %{data: render_one(order_payload, OrderPayloadParserWeb.OrderView, "order.json")}
  end

  def render("order.json", %{order: order_payload}) do
    order_payload
  end
end
