defmodule OrderPayloadParser do
  @moduledoc """
  OrderPayloadParser keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def parse(payload) do
    %{
      "externalCode"   => payload["id"] |> to_str,
      "storeId"        => payload["store_id"],
      "subTotal"       => payload["total_amount"] |> to_str,
      "deliveryFee"    => payload["total_shipping"] |> to_str,
      "total_shipping" => payload["total_shipping"] |> to_str,
      "total"          => payload["total_amount_with_shipping"] |> to_str,
      "country"        => fetch_country_id(payload),
      "state"          => fetch_state_name(payload),
      "city"           => fetch_city_name(payload),
      "district"       => fetch_district_name(payload),
      "street"         => receiver_address(payload)["street_name"],
      "complement"     => receiver_address(payload)["comment"],
      "latitude"       => receiver_address(payload)["latitude"],
      "longitude"      => receiver_address(payload)["longitude"],
      "dtOrderCreate"  => payload["date_created"],
      "postalCode"     => receiver_address(payload)["zip_code"],
      "number"         => receiver_address(payload)["street_number"],
      "customer" => %{
        "externalCode" => get_in(payload, ["buyer", "id"]) |> to_str,
        "name"         => get_in(payload, ["buyer", "nickname"]),
        "email"        => get_in(payload, ["buyer", "email"]),
        "contact"      => customer_phone_number(payload),
      },
      "items"    => fetch_order_items(payload),
      "payments" => fetch_payment_info(payload)
    }
  end

  defp fetch_payment_info(payload) do
    payload["payments"]
    |> Enum.map(&build_payment_info/1)
  end

  defp build_payment_info(payment) do
    %{
      "type"  => String.upcase(payment["payment_type"]),
      "value" => payment["total_paid_amount"]
    }
  end

  defp fetch_order_items(payload) do
    payload["order_items"]
    |> Enum.map(&build_order_item/1)
  end

  defp build_order_item(item) do
    item_quantity = item["quantity"]
    item_price = item["unit_price"]

    %{
      "externalCode" => get_in(item, ["item", "id"]),
      "name"         => get_in(item, ["item", "title"]),
      "price"        => item_price,
      "quantity"     => item_quantity,
      "total"        => item_price * item_quantity,
        "subItems"   => []
    }
  end

  defp customer_phone_number(payload) do
    phone_info = get_in(payload, ["buyer", "phone"])

    "#{phone_info["area_code"]}#{phone_info["number"]}"
  end

  defp fetch_district_name(payload) do
    payload
    |> receiver_address
    |> get_in(["neighborhood", "name"])
  end

  defp fetch_city_name(payload) do
    payload
    |> receiver_address
    |> get_in(["city", "name"])
  end

  defp fetch_state_name(payload) do
    payload
    |> receiver_address
    |> get_in(["state", "name"])
  end

  defp fetch_country_id(payload) do
    payload
    |> receiver_address
    |> get_in(["country", "id"])
  end

  defp receiver_address(payload) do
    get_in(payload, ["shipping", "receiver_address"])
  end

  defp to_str(value) when is_integer(value), do: Integer.to_string(value)
  defp to_str(value) when is_float(value), do: :erlang.float_to_binary(value, decimals: 2)
end
