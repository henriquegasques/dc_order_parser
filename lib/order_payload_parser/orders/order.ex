defmodule OrderPayloadParser.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :customer, :map
    field :deliveryFee, :decimal
    field :externalCode, :string
    field :items, {:array, :map}
    field :payments, {:array, :map}
    field :storeId, :integer
    field :subTotal, :decimal
    field :total, :decimal
    field :total_shipping, :decimal
    field :country, :string
    field :state, :string
    field :city, :string
    field :district, :string
    field :street, :string
    field :complement, :string
    field :latitude, :float
    field :longitude, :float
    field :postalCode, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, 
      [
        :externalCode,
        :storeId,
        :subTotal,
        :deliveryFee,
        :total_shipping,
        :country,
        :state,
        :city,
        :district,
        :street,
        :complement,
        :latitude,
        :longitude,
        :postalCode,
        :total,
        :customer,
        :items,
        :payments
      ]
    )
    |> validate_required(
      [
        :externalCode,
        :storeId,
        :subTotal,
        :deliveryFee,
        :total_shipping,
        :country,
        :state,
        :city,
        :district,
        :street,
        :complement,
        :latitude,
        :longitude,
        :postalCode,
        :total,
        :customer,
        :items,
        :payments
      ]
    )
  end
end
