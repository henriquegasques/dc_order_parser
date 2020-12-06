defmodule OrderPayloadParser.OrdersTest do
  use OrderPayloadParser.DataCase

  alias OrderPayloadParser.Orders

  describe "orders" do
    alias OrderPayloadParser.Orders.Order

    @valid_attrs %{customer: %{}, deliveryFee: "120.5", externalCode: "some externalCode", items: [%{}], payments: [%{}], storeId: 42, subTotal: "120.5", total: "120.5", total_shipping: "120.5", country: "BR", state: "some state", street: "some street", complement: "some complement", latitude: -34.23234176635742, longitude: -24.349287033081055, postalCode: "some postalCode", city: "some city", district: "some district"}
    @update_attrs %{customer: %{}, deliveryFee: "456.7", externalCode: "some updated externalCode", items: [%{}], payments: [%{}], storeId: 43, subTotal: "456.7", total: "456.7", total_shipping: "456.7", country: "BR", state: "some state", street: "some street", complement: "some complement", latitude: -34.232343, longitude: -24.349287, postalCode: "some postalCode", city: "some city", district: "some district"}
    @invalid_attrs %{customer: nil, deliveryFee: nil, externalCode: nil, items: nil, payments: nil, storeId: nil, subTotal: nil, total: nil, total_shipping: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_attrs)
      assert order.customer == %{}
      assert order.deliveryFee == Decimal.new("120.5")
      assert order.externalCode == "some externalCode"
      assert order.items == [%{}]
      assert order.payments == [%{}]
      assert order.storeId == 42
      assert order.subTotal == Decimal.new("120.5")
      assert order.total == Decimal.new("120.5")
      assert order.total_shipping == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Orders.update_order(order, @update_attrs)
      assert order.customer == %{}
      assert order.deliveryFee == Decimal.new("456.7")
      assert order.externalCode == "some updated externalCode"
      assert order.items == [%{}]
      assert order.payments == [%{}]
      assert order.storeId == 43
      assert order.subTotal == Decimal.new("456.7")
      assert order.total == Decimal.new("456.7")
      assert order.total_shipping == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
