# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it { should have_many(:frames) }
    it { should validate_presence_of(:player_1) }
    it { should validate_numericality_of(:current_player).only_integer }
    it { should validate_numericality_of(:current_frame).only_integer }
    it { should validate_inclusion_of(:current_frame).in_range(1..10) }
  end
end
