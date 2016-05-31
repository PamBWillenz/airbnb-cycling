require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:member) }
  it { should validate_presence_of(:bio) }
  it { should validate_presence_of(:member_id) }
end
