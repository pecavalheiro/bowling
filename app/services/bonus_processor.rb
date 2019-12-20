# frozen_string_literal: true

class BonusProcessor < ApplicationService
  attr_reader :current_frame, :current_player, :pending_bonuses

  def initialize(frame)
    @current_frame = frame
    @current_player = frame.player_id
    @pending_bonuses = \
      Bonus.where('player_id = ? AND game_id =? AND throws_to_sum > 0',
                  current_player, current_frame.game.id)
  end

  def call
    apply_pending_bonus!

    return if current_frame.number == 10

    create_strike_bonus if strike?
    create_spare_bonus if spare?
  end

  def apply_pending_bonus!
    return unless pending_bonuses.any?

    pending_bonuses.each do |pending_bonus|
      pending_bonus.frame.bonus += last_throw_score
      pending_bonus.frame.save!

      pending_bonus.throws_to_sum -= 1
      pending_bonus.save!
    end
  end

  def last_throw_score
    current_frame.ball_2 || current_frame.ball_1
  end

  def create_strike_bonus
    create_bonus_for_current_frame(2)
  end

  def create_spare_bonus
    create_bonus_for_current_frame(1)
  end

  def create_bonus_for_current_frame(throws_to_sum)
    Bonus.create!(frame: current_frame,
                  game: current_frame.game,
                  player_id: current_player,
                  throws_to_sum: throws_to_sum)
  end
end
