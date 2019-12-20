# frozen_string_literal: true

class Bonus < ApplicationRecord
  belongs_to :frame
  belongs_to :game

  validates_presence_of :player_id
  validates_presence_of :frame
  validates_presence_of :throws_to_sum
end
