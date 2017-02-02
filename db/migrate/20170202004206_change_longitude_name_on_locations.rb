class ChangeLongitudeNameOnLocations < ActiveRecord::Migration[5.0]
  def change
    rename_column :locations, :longititude, :longitude
  end
end
