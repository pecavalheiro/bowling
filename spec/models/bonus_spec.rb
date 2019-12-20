# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bonus, type: :model do
  describe 'validations' do
    it { should belong_to(:frame) }
    it { should belong_to(:game) }
    it { should validate_presence_of(:frame) }
    it { should validate_presence_of(:player_id) }
    it { should validate_presence_of(:throws_to_sum) }
  end
end
