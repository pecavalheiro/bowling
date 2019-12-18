# frozen_string_literal: true

class ThrowProcessor < ApplicationService
  attr_reader :game, :knocked_pins

  def initialize(game, knocked_pins)
    @game = game
    @knocked_pins = knocked_pins
  end

  def call; end
end
