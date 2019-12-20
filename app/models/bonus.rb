class Bonus < ApplicationRecord
  belongs_to :frame

  validates_presence_of :player_id
  validates_presence_of :frame
  validates_presence_of :applied
end
