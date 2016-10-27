class AddProfilePicToProfile < ActiveRecord::Migration[5.0]
  def up
    add_attachment :profiles, :profile_pic
  end
  
  def down
    remove_attachment :profiles, :profile_pic
  end
end
