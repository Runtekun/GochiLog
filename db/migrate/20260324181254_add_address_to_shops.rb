class AddAddressToShops < ActiveRecord::Migration[7.2]
  def change
    add_column :shops, :address, :string
  end
end
