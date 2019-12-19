# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThrowProcessor do
  describe '#call' do
    let!(:game) { FactoryBot.create(:game, current_player: player_id) }
    let(:knocked_pins) { 5 }
    subject { ThrowProcessor.call(game, knocked_pins) }

    RSpec.shared_examples 'ball 1 of < 10 frame' do |player_id|
      context 'when current ball is 1' do
        it 'records the score for the first ball' do
          subject
          expect(first_frame.ball_1).to eq 5
        end

        it "keeps player #{player_id} as current_player" do
          subject
          expect(game.reload.current_player).to eq player_id
        end
      end
    end

    RSpec.shared_examples 'ball 2 of < 10 frame' do
      it 'records the score for second ball without changing the first ball' do
        subject
        first_frame.reload
        expect(first_frame.ball_1).to eq 3
        expect(first_frame.ball_2).to eq 5
      end
    end

    context 'when current player is 1' do
      let(:player_id) { 1 }
      context 'when current frame is < 10' do
        let(:first_frame) { Frame.find_by(player_id: 1, number: 1) }
        it_behaves_like 'ball 1 of < 10 frame', 1
        context 'when current ball is 2' do
          before do
            first_frame.update(ball_1: 3)
          end

          it_behaves_like 'ball 2 of < 10 frame'

          it 'changes current_player to 2 with the same frame' do
            subject
            game.reload
            expect(game.current_player).to eq(2)
            expect(game.current_frame).to eq(1)
          end
        end
      end
    end

    context 'when current player is 2' do
      let(:player_id) { 2 }

      context 'when current frame is < 10' do
        let(:first_frame) { Frame.find_by(player_id: 2, number: 1) }

        it_behaves_like 'ball 1 of < 10 frame', 2

        context 'when current ball is 2' do
          before do
            first_frame.update(ball_1: 3)
          end

          it_behaves_like 'ball 2 of < 10 frame'

          it 'changes current_player to 1 while advancing the frame' do
            subject
            game.reload
            expect(game.current_player).to eq(1)
            expect(game.current_frame).to eq(2)
          end
        end
      end
    end
  end
end
