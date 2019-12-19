# frozen_string_literal: true

class Game::ThrowsController < ApplicationController
  before_action :set_game, only: %i[create]

  def create
    begin
      ThrowProcessor.call(@game, game_params[:knocked_pins])
    rescue InvalidPinCountError
      return head :unprocessable_entity
    rescue GameHasEndedError
      return head :forbidden
    end

    head :ok
  end

  private

  def set_game
    @game = Game.last!
  end

  def game_params
    params.require(:throw).permit(:knocked_pins)
  end
end
