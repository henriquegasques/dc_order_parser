defmodule OrderPayloadParserWeb.OrderControllerTest do
  use OrderPayloadParserWeb.ConnCase

  describe "create" do
    test "creates and renders information about the created order", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), payload())

      assert %{"data" => _response} = json_response(conn, 200)
    end
  end

  defp payload do
    filename = Path.expand("../../support/payload.json", __DIR__)

    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body), do: json
  end
end
