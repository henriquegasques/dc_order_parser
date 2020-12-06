defmodule OrderPayloadParserWeb.OrderControllerTest do
  use OrderPayloadParserWeb.ConnCase

  describe "when the parsed order is successfully validated by the validation API" do
    test "persists the order and renders information about it", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), payload())

      [created_order | _] = OrderPayloadParser.Orders.list_orders

      assert %{"data" => response} = json_response(conn, 200)
      assert response["total"] == "254.64"

      assert created_order.externalCode == response["externalCode"]
    end
  end

  describe "when the parsed order is invalidated by the validation API" do
    test "returns the error and does not persist the order", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), %{})

      assert %{"error" => response} = json_response(conn, 400)
      assert response =~ "externalCode, storeId, subTotal, deliveryFee, total, country"
      assert response =~ "state, city, district, street, complement, latitude, longitude"
      assert response =~ "dtOrderCreate, postalCode, number, items, payments, total_shipping] are required"
    end
  end

  defp payload do
    filename = Path.expand("../../support/payload.json", __DIR__)

    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body), do: json
  end
end
