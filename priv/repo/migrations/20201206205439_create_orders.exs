defmodule OrderPayloadParser.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :externalCode, :string
      add :storeId, :integer
      add :subTotal, :decimal
      add :deliveryFee, :decimal
      add :total_shipping, :decimal
      add :country, :string
      add :state, :string
      add :city, :string
      add :district, :string
      add :street, :string
      add :complement, :string
      add :latitude, :real
      add :longitude, :real
      add :postalCode, :string
      add :total, :decimal
      add :shipping_address, :map
      add :customer, :map
      add :items, {:array, :map}
      add :payments, {:array, :map}

      timestamps()
    end

  end
end
