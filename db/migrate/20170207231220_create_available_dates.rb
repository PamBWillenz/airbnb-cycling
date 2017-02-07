class CreateAvailableDates < ActiveRecord::Migration[5.0]
  def change
    create_table :available_dates do |t|
      t.date :available_date
      t.references :location, foreign_key: true
      t.boolean :booked, default: false

      t.timestamps
    end
  end
end
