class AddPriceToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :price, :float
  end
end
