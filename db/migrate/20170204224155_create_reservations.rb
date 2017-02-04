class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.references :location, foreign_key: true
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
