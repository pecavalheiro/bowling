# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it { should have_many(:frames) }
    it { should have_many(:bonuses) }
    it { should validate_presence_of(:player_1) }
    it { should validate_numericality_of(:current_player).only_integer }
    it { should validate_numericality_of(:current_frame).only_integer }
    it { should validate_inclusion_of(:current_frame).in_range(1..10) }
  end

  describe '#new' do
    context 'when creating a new game' do
      it 'assigns 10 frames for every player' do
        expect do
          FactoryBot.create(:game)
        end.to change(Frame, :count).by(20)
        expect(Frame.where(player_id: 1).count).to eq(10)
        expect(Frame.where(player_id: 2).count).to eq(10)
      end
      it 'does not assign frames to a non existing player' do
        expect do
          FactoryBot.create(:game, player_2: nil)
        end.to change(Frame, :count).by(10)
        expect(Frame.where(player_id: 1).count).to eq(10)
        expect(Frame.where(player_id: 2).count).to eq(0)
      end
    end
  end
end
