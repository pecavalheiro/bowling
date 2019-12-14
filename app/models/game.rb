# frozen_string_literal: true

# The Game class holds the overall game logic and is the central part of the
# application
class Game < ApplicationRecord
  has_many :frames
  validates_presence_of :player1
  validates_numericality_of :current_player, only_integer: true
  validates_numericality_of :current_frame, only_integer: true
  validates_inclusion_of :current_frame, in: 1..10
  validates_format_of :state, with: /\A(running|ended)\z/,
                              message: 'State must be running or ended'
end
