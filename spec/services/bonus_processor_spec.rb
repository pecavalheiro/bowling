# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BonusProcessor do
  let(:game) { FactoryBot.create(:game) }

  describe '#call' do
    subject { BonusProcessor.call(frame) }

    context 'frame is 10' do
      context 'frame is strike' do
        let(:frame) do
          FactoryBot.create(:frame, game: game, number: 10, ball_1: 10, ball_2: 5)
        end
        it 'does not create a new bonus' do
          expect do
            subject
          end.not_to change(Bonus, :count)
        end
      end
      context 'frame is spare' do
        let(:frame) do
          FactoryBot.create(:frame, game: game, number: 10, ball_1: 5, ball_2: 5)
        end
        it 'does not create a new bonus' do
          expect do
            subject
          end.not_to change(Bonus, :count)
        end
      end
    end

    context 'frame is strike' do
      let(:frame) { FactoryBot.create(:frame, :strike) }

      it 'creates two throws to sum' do
        expect do
          subject
        end.to change(Bonus, :count).by(1)

        expect(Bonus.last.throws_to_sum).to eq 2
      end
    end

    context 'frame is spare' do
      let(:frame) { FactoryBot.create(:frame, :spare) }
      it 'creates one bonus to sum' do
        expect do
          subject
        end.to change(Bonus, :count).by(1)

        expect(Bonus.last.throws_to_sum).to eq 1
      end
    end

    context 'frame is not spare or strike' do
      let(:frame) { FactoryBot.create(:frame, :low_score) }

      it 'does not create any bonus to sum' do
        expect do
          subject
        end.not_to change(Bonus, :count)

        expect(frame.bonuses).to eq []
      end
    end

    context 'when non applied bonus exist for player' do
      let!(:frame_with_bonus) do
        FactoryBot.create(:frame,
                          game: game,
                          bonuses: [bonus])
      end
      let(:bonus) { FactoryBot.create(:bonus, game: game, throws_to_sum: 2) }
      let(:frame) { FactoryBot.create(:frame, :strike, game: game) }

      it 'applies one bonus for each throw' do
        subject
        expect(frame_with_bonus.reload.bonus).to eq(10)
        expect(bonus.reload.throws_to_sum).to eq(1)
      end

      context 'when bonus value already exists in frame' do
        let!(:frame_with_bonus) do
          FactoryBot.create(:frame, bonus: 5, bonuses: [bonus], game: game)
        end
        it 'sums new bonus to already existing value' do
          subject
          expect(frame_with_bonus.reload.bonus).to eq 15
        end
      end

      context 'when bonus from old games already exist' do
        let(:old_game) { FactoryBot.create(:game) }
        before do
          FactoryBot.create(:bonus, game: old_game, frame: old_game.frames.first)
        end

        it 'does not apply the old bonuses' do
          expect do
            subject
          end.not_to change(old_game.bonuses.first, :throws_to_sum)
        end
      end
    end
  end
end
