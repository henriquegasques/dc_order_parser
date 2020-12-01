defmodule OrderPayloadParserWeb.OrderControllerTest do
  use OrderPayloadParserWeb.ConnCase

  describe "parse and create order" do
    test "", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @create_attrs)

      assert %{"data" => data} = json_response(conn, 200)
    end
  end
end
