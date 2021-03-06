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
      before do
        allow(BonusProcessor).to receive(:call)
      end

      after do
        expect(BonusProcessor).to have_received(:call)
      end

      context 'and current frame is < 10' do
        it_behaves_like 'frame < 10, ball 1', 1

        context 'and current ball is 2' do
          before do
            frame.update(ball_1: 3)
          end

          it_behaves_like 'frame < 10, ball 2'

          context 'and player 2 exists' do
            it 'changes current_player to 2 in the same frame' do
              subject
              game.reload
              expect(game.current_player).to eq(2)
              expect(game.current_frame).to eq(1)
            end

            context 'when total knocked_pins = 0' do
              let(:knocked_pins) { 0 }

              before do
                frame.update(ball_1: 0)
              end

              it 'changes the current_player without changing frame' do
                subject
                game.reload
                expect(game.current_player).to eq(next_player)
                expect(game.current_frame).to eq(1)
              end
            end
          end
          context 'and player 2 does not exist' do
            let!(:game) do
              FactoryBot.create(:game,
                                current_player: player_id,
                                player_2: nil)
            end
            it 'keeps current player while advancing the frame' do
              subject
              expect(game.current_player).to eq(1)
              expect(game.current_frame).to eq(2)
            end
            context 'when total knocked_pins = 0' do
              let(:knocked_pins) { 0 }

              before do
                frame.update(ball_1: 0)
              end

              it 'keeps the current_player while advancing frame' do
                subject
                game.reload
                expect(game.current_player).to eq(1)
                expect(game.current_frame).to eq(2)
              end
            end
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

        context 'when throwing the extra ball' do
          before do
            frame.update(ball_1: 10, ball_2: 10)
          end
          it 'changes the player to 2 without changing the frame' do
            subject
            game.reload
            expect(game.current_player).to eq(2)
            expect(game.current_frame).to eq(10)
          end
        end

        context 'and player 2 does not exist' do
          let!(:game) do
            FactoryBot.create(:game,
                              current_player: player_id,
                              player_2: nil)
          end

          context 'and ball 1 + ball 2 = 0' do
            before do
              frame.update(ball_1: 0)
            end
            let(:knocked_pins) { 0 }

            it 'records the score' do
              subject
              expect(frame.reload.ball_2).to eq 0
            end
          end

          context 'and first throw score = 10 (strike)' do
            let(:knocked_pins) { 5 }

            before do
              frame.update(ball_1: 10)
            end

            it 'keeps the player and frame, allowing a third throw' do
              subject
              expect(game.current_player).to eq(1)
              expect(game.current_frame).to eq(10)
            end

            context 'extra throw' do
              before do
                frame.update(ball_1: 10, ball_2: 5)
              end
              it 'records the score' do
                subject
                expect(frame.reload.ball_extra).to eq 5
              end
            end
          end
        end

        context 'and ball 1 + ball 2 < 10' do
          before do
            frame.update(ball_1: 1)
          end
          let(:knocked_pins) { 7 }

          it 'changes current player to 2 in the same frame' do
            subject
            expect(game.current_player).to eq(2)
            expect(game.current_frame).to eq(10)
          end
        end
      end
    end

    context 'when current player is 2' do
      let(:player_id) { 2 }

      context 'and current frame is < 10' do
        it_behaves_like 'frame < 10, ball 1', 2

        context 'and knocked_pins is 10 (strike)' do
          let(:knocked_pins) { 10 }

          it 'changes current_player to 1 while advancing the frame' do
            subject
            game.reload
            expect(game.current_player).to eq(1)
            expect(game.current_frame).to eq(2)
          end
        end

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

          context 'when total knocked_pins = 0' do
            let(:knocked_pins) { 0 }

            before do
              frame.update(ball_1: 0)
            end

            it 'changes the current_player while advancing frame' do
              subject
              game.reload
              expect(game.current_player).to eq(next_player)
              expect(game.current_frame).to eq(2)
            end
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

        context 'and ball 1 + ball 2 < 10' do
          before do
            frame.update(ball_1: 1)
          end
          let(:knocked_pins) { 7 }

          it 'keeps current player and frame' do
            subject
            expect(game.current_player).to eq(2)
            expect(game.current_frame).to eq(10)
          end

          context 'when throwing a new ball' do
            before do
              frame.update(ball_1: 1, ball_2: 5)
            end
            it 'raises GameHasEndedError' do
              expect do
                ThrowProcessor.call(game, 4)
              end.to raise_error(GameHasEndedError)
            end
          end
        end
      end
    end
  end
end
