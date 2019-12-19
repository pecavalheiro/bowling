# frozen_string_literal: true

class ThrowProcessor < ApplicationService
  attr_reader :game, :knocked_pins

  def initialize(game, knocked_pins)
    @game = game
    @knocked_pins = knocked_pins
  end

  def call
    score_throw_in_current_frame
    change_player if next_player?
    change_frame if next_frame?
  end

  def score_throw_in_current_frame
    current_frame.current_ball = knocked_pins
    current_frame.save!
  end

  def next_frame?
    return true unless current_frame.ball_2.nil? || current_player == 1
  end

  def next_player?
    return true unless current_frame.ball_2.nil?
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
