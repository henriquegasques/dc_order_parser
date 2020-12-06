defmodule OrderPayloadParser.OrderValidationAPIClient do
  def validate_order(order_payload) do
    "https://delivery-center-recruitment-ap.herokuapp.com"
    |> HTTPoison.post(
      Jason.encode!(order_payload),
      [
        {"Content-Type", "application/json"},
        {"X-Sent", current_date_and_time},
      ])
  end

  defp current_date_and_time do
    {{year, month, day}, {hour, minutes, _second}} = :calendar.local_time()
    short_year = "#{year}" |> String.slice(2..-1)
    full_minutes = "#{minutes}" |> String.pad_leading(2, "0")

    "#{hour}h#{full_minutes} - #{day}/#{month}/#{short_year}"
  end
end
