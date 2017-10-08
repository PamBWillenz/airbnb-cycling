class AddCustomerChargeIdToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :customer_charge_id, :string
  end
end
