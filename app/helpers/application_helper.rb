module ApplicationHelper
  def has_profile?
    current_member.profile != nil 
  end
end
