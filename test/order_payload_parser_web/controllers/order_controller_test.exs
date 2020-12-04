defmodule OrderPayloadParserWeb.OrderControllerTest do
  use OrderPayloadParserWeb.ConnCase

  describe "when the parsed order is successfully validated by the validation API" do
    test "persists the order and renders information about it", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), payload())

      assert %{"data" => _response} = json_response(conn, 200)
    end
  end

  describe "when the parsed order is invalidated by the validation API" do
    test "returns the errer and does not persist the order", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), %{invalid: "payload"})

      assert %{"data" => _response} = json_response(conn, 400)
    end
  end

  defp payload do
    filename = Path.expand("../../support/payload.json", __DIR__)

    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body), do: json
  end
end
