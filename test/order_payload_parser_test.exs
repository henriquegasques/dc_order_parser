defmodule OrderPayloadParser.Parser.OrderPayloadParser.ParserTest do
  use ExUnit.Case, async: true

  describe "parse" do
    test "parses the payload" do
      result = OrderPayloadParser.Parser.parse(payload())

      assert result == expected_result()
    end
  end

  defp payload do
    filename = Path.expand("./support/payload.json", __DIR__)

    read_json_fixture(filename)
  end

  defp expected_result do
    filename = Path.expand("./support/processed_payload.json", __DIR__)

    read_json_fixture(filename)
  end

  defp read_json_fixture(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body), do: json
  end
end
