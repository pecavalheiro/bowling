# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game, only: %i[index]

  # GET /games
  def index
    render json: GameSerializer.new(@game, include: [:frames])
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      head :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def set_game
    @game = Game.last
  end

  def game_params
    params.require(:game).permit(:player_1, :player_2)
  end
end
