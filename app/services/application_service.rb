# frozen_string_literal: true

class ApplicationService
  attr_reader :game, :knocked_pins

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(game, knocked_pins)
    @game = game
    @knocked_pins = knocked_pins
    set_internals
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

  def current_frame
    @current_frame ||= @game.frames
                            .find_by(player_id: current_player,
                                     number: @game.current_frame)
  end

  def current_player
    @current_player ||= @game.current_player
  end
end
