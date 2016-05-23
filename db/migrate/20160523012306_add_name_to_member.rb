class AddNameToMember < ActiveRecord::Migration
  def change
    add_column :members, :name, :string
  end
end
