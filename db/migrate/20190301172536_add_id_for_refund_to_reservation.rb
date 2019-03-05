class AddIdForRefundToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :id_for_refund, :string
  end
end
