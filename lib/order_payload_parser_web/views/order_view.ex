defmodule OrderPayloadParserWeb.OrderView do
  use OrderPayloadParserWeb, :view

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderPayloadParserWeb.OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      externalCode: "9987071",
      storeId: 282,
      subTotal: "49.90",
      deliveryFee: "5.14",
      total: "55.04",
      country: "BR",
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
          type: "CREDIT_CARD",
          value: 55.04
        }
      ]
    }
  end
end
