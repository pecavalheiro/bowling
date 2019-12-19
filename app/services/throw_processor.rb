# frozen_string_literal: true

class ThrowProcessor < ApplicationService
  attr_reader :game, :knocked_pins

  def initialize(game, knocked_pins)
    @game = game
    @knocked_pins = knocked_pins
    set_internals
  end

  def call
    raise GameHasEndedError if game_has_ended?

    score_throw_in_current_frame
    change_player if next_player?
    change_frame if next_frame?
  end

  def game_has_ended?
    current_player == 2 && \
      current_frame.number == 10 && \
      current_frame.ball_1? && \
      current_frame.ball_2? && \
      (current_frame.ball_1 + current_frame.ball_2) < 10
  end

  def score_throw_in_current_frame
    current_frame.current_ball = knocked_pins
    current_frame.save!
  end

  def next_frame?
    case current_player
    when 2
      return false if (current_frame.number == 10) && spare?
      return true unless current_frame.ball_2.nil? || current_frame.number == 10
    end
  end

  def next_player?
    case current_frame.number
    when 1..9
      return true if strike? || current_frame.ball_2?
    when 10
      return true if current_frame.ball_2? && !spare? && current_player != 2
    end
  end

  def strike?
    current_frame.ball_1 == 10
  end

  def spare?
    current_frame.ball_1.to_i < 10 &&
      (current_frame.ball_1.to_i + current_frame.ball_2.to_i) == 10
  end

  def set_internals
    current_frame
    current_player
  end

  def change_frame
    @game.current_frame += 1
    @game.save!
  end

  def change_player
    @game.current_player = (@game.current_player == 1 ? 2 : 1)
    @game.save!
  end

  def current_frame
    @current_frame ||= @game.frames
                            .find_by(player_id: current_player,
                                     number: @game.current_frame)
  end

  def current_player
    @current_player ||= @game.current_player
  end
end
