class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :title
      t.text :description
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postcode
      t.string :bike_type

      t.integer :guests
      t.integer :member_id
      t.float :latitude
      t.float :longititude

      t.references :member, foreign_key: true


      t.timestamps
    end
  end
end
