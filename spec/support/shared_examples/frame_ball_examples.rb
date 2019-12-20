# frozen_string_literal: true

RSpec.shared_examples 'frame 10, ball 1' do |player_id|
  context 'and knocked_pins = 10' do
    let(:knocked_pins) { 10 }

    it 'records the score' do
      subject
      expect(frame.ball_1).to eq 10
    end

    it 'keeps the current_player, allowing a new throw' do
      subject
      game.reload
      expect(game.current_player).to eq(player_id)
      expect(game.current_frame).to eq(10)
    end
  end
end

RSpec.shared_examples 'frame 10, ball 2' do |player_id|
  context 'when knocked_pins = 10' do
    let(:knocked_pins) { 10 }

    before do
      frame.update(ball_1: 10)
    end

    it 'records the score' do
      subject
      expect(frame.reload.ball_2).to eq 10
    end

    it 'keeps the current_player, allowing a new throw' do
      subject
      game.reload
      expect(game.current_player).to eq(player_id)
      expect(game.current_frame).to eq(10)
    end
  end

  context 'and ball 1 + ball 2 = 10 (spare)' do
    before do
      frame.update(ball_1: 4)
    end
    let(:knocked_pins) { 6 }

    it 'records the score' do
      subject
      expect(frame.reload.ball_2).to eq 6
    end

    it 'keeps the current_player, allowing a new throw' do
      subject
      game.reload
      expect(game.current_player).to eq(player_id)
      expect(game.current_frame).to eq(10)
    end
  end

  context 'and ball 1 + ball 2 < 10' do
    before do
      frame.update(ball_1: 1)
    end
    let(:knocked_pins) { 7 }

    it 'records the score' do
      subject
      expect(frame.reload.ball_2).to eq 7
    end
  end
end

RSpec.shared_examples 'frame < 10, ball 1' do |player_id|
  it 'records the score for the first ball' do
    subject
    expect(frame.ball_1).to eq 5
  end

  it "keeps player #{player_id} as current_player" do
    subject
    expect(game.reload.current_player).to eq player_id
  end

  context 'when knocked_pins is 10 (strike)' do
    let(:knocked_pins) { 10 }

    it 'records the score for first ball' do
      subject
      expect(frame.ball_1).to eq 10
    end

    it 'advances to next player without scoring the second ball' do
      subject
      expect(game.reload.current_player).to eq next_player
      expect(frame.ball_2).to be_nil
    end
  end
end

RSpec.shared_examples 'frame < 10, ball 2' do
  it 'records the score for second ball without changing the first ball' do
    subject
    frame.reload
    expect(frame.ball_1).to eq 3
    expect(frame.ball_2).to eq 5
  end
end
