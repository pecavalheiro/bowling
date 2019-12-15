FactoryBot.define do
  factory :frame do
    association :game
    number { 1 }
    bonus { 0 }
    player_id { 1 }
  end
end
