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
    return if current_frame.number != 10
    return if current_player == 1 && @game.player_2.present?

    if strike? || spare?
      return true if current_frame.ball_extra.present?
    else
      current_frame.ball_1.present? && current_frame.ball_2.present?
    end
  end

  def score_throw_in_current_frame
    current_frame.current_ball = knocked_pins
    current_frame.save!
  end

  def next_frame?
    return false if (current_frame.number == 10) && (spare? || strike?)

    case current_player
    when 1
      return false if current_frame.number == 10 || @game.player_2.present?
      return true if strike?
      return true if current_frame.ball_2.present?
    when 2
      return true if strike?
      return true unless current_frame.ball_2.nil? || current_frame.number == 10
    end
  end

  def next_player?
    return unless @game.player_2.present?

    case current_frame.number
    when 1..9
      # strike skips the second ball
      return true if strike? || current_frame.ball_2.present?
    when 10
      # only change player if current player = 1
      # after last throw of player 2, game state is kept as is
      return if current_player == 2

      # if player scores strike or spare, gets a bonus throw
      if spare? || strike?
        return true if current_frame.ball_extra.present?
      else
        return true if current_frame.ball_2.present?
      end
    end
  end

  def change_frame
    @game.current_frame += 1
    @game.save!
  end

  def change_player
    @game.current_player = (@game.current_player == 1 ? 2 : 1)
    @game.save!
  end

  def set_internals
    current_frame
    current_player
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
