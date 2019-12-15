# frozen_string_literal: true

# The Game class holds the overall game logic and is the central part of the
# application
class Game < ApplicationRecord
  has_many :frames
  validates_presence_of :player_1
  validates_numericality_of :current_player, only_integer: true
  validates_numericality_of :current_frame, only_integer: true
  validates_inclusion_of :current_frame, in: 1..10

  after_create :initialize_frames

  private

  def initialize_frames
    add_frames_to_player(1)
    add_frames_to_player(2) if player_2.present?
  end

  def add_frames_to_player(player_id)
    10.times do |n|
      Frame.create!(game_id: id, number: n + 1, player_id: player_id)
    end
  end
end
