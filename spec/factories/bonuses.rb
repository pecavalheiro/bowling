FactoryBot.define do
  factory :bonus do
    association :game
    association :frame
    throws_to_sum { 1 }
    player_id { 1 }
  end
end
