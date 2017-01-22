class CreateLocationImages < ActiveRecord::Migration[5.0]
  def change
    create_table :location_images do |t|
      t.string :caption
      t.integer :picture_order
      t.attachment :picture
      t.references :location, index: true, foreign_key: true

      t.timestamps
    end
  end
end
