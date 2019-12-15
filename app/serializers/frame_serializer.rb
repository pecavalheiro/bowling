# frozen_string_literal: true

class FrameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :number, :player_id, :ball_1, :ball_2, :ball_extra, :total_points
end
