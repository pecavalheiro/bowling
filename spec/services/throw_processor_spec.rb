# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThrowProcessor do
  describe '#call' do
    let!(:game) { FactoryBot.create(:game, current_player: player_id) }
    let(:knocked_pins) { 5 }
    let(:next_player) { player_id == 1 ? 2 : 1 }
    let(:player_id) { 1 }
    let(:frame_number) { 1 }
    let(:frame) { Frame.find_by(player_id: player_id, number: frame_number) }
    subject { ThrowProcessor.call(game, knocked_pins) }

    context 'when current player is 1' do
      context 'and current frame is < 10' do

        it_behaves_like 'frame < 10, ball 1', 1

        context 'and current ball is 2' do
          before do
            frame.update(ball_1: 3)
          end

          it_behaves_like 'frame < 10, ball 2'

          it 'changes current_player to 2 in the same frame' do
            subject
            game.reload
            expect(game.current_player).to eq(2)
            expect(game.current_frame).to eq(1)
          end
        end
      end

      context 'and current frame is 10' do
        let(:frame_number) { 10 }

        before do
          game.update(current_frame: 10)
        end

        it_behaves_like 'frame 10, ball 1', 1
        it_behaves_like 'frame 10, ball 2', 1
      end
    end

    context 'when current player is 2' do
      let(:player_id) { 2 }

      context 'and current frame is < 10' do
        it_behaves_like 'frame < 10, ball 1', 2

        context 'and current ball is 2' do
          before do
            frame.update(ball_1: 3)
          end

          it_behaves_like 'frame < 10, ball 2'

          it 'changes current_player to 1 while advancing the frame' do
            subject
            game.reload
            expect(game.current_player).to eq(1)
            expect(game.current_frame).to eq(2)
          end
        end
      end

      context 'and current frame is 10' do
        let(:frame_number) { 10 }

        before do
          game.update(current_frame: 10)
        end

        it_behaves_like 'frame 10, ball 1', 2
        it_behaves_like 'frame 10, ball 2', 2
      end
    end
  end
end
