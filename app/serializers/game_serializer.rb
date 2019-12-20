# frozen_string_literal: true

class GameSerializer
  include FastJsonapi::ObjectSerializer

  has_many :frames

  attributes :player_1_score, :player_2_score
end
