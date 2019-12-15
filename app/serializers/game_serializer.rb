class GameSerializer
  include FastJsonapi::ObjectSerializer

  has_many :frames
end
