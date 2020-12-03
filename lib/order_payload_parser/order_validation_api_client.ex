defmodule OrderPayloadParser.OrderValidationAPIClient do
  def validate_order(order_payload) do
    "https://delivery-center-recruitment-ap.herokuapp.com"
    |> HTTPoison.post(Jason.encode!(order_payload), [{"Content-Type", "application/json"}])
  end
end
