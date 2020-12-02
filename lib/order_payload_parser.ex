defmodule OrderPayloadParser do
  @moduledoc """
  OrderPayloadParser keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def parse(payload) do
    %Order{
      externalCode: Integer.to_string(payload["id"]),
      storeId: payload["store_id"],
      subTotal: payload["total_amount"],
      deliveryFee: payload["LoL"],
      total: payload["total_amount_with_shipping"],
      country: "lol",
      state: "SP",
      city: "Cidade de Testes",
      district: "Bairro Fake",
      street: "Rua de Testes Fake",
      complement: "galpao",
      latitude: -23.629037,
      longitude:  -46.712689,
      dtOrderCreate: "2019-06-27T19:59:08.251Z",
      postalCode: "85045020",
      number: "0",
      customer: %{
        externalCode: "136226073",
        name: "JOHN DOE",
        email: "john@doe.com",
        contact: "41999999999",
      },
      items: [
        %{
          externalCode: "IT4801901403",
          name: "Produto de Testes",
          price: 49.9,
          quantity: 1,
          total: 49.9,
          subItems: []
        }
      ],
      payments: [
        %{
          type: "CREDIT_CAR",
          value: 55.04
        }
      ]
    }
  end
end
