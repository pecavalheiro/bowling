require 'rails_helper'

RSpec.describe Bonus, type: :model do
  describe 'validations' do
    it { should belong_to(:frame) }
    it { should validate_presence_of(:frame) }
    it { should validate_presence_of(:player_id) }
    it { should validate_presence_of(:applied) }
  end
end
