# frozen_string_literal: true

class Frame < ApplicationRecord
  belongs_to :game

  validates :game_id, :number, :player_id, presence: true

  validates_inclusion_of :player_id, in: [1, 2]

  validates_numericality_of :number, only_integer: true
  validates_inclusion_of :number, in: 1..10

  validates :ball_1, :ball_2, :ball_extra,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10,
                            allow_nil: true}

  validates_numericality_of :bonus, only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 20
end
