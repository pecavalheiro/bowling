FactoryBot.define do
  factory :bonus do
    association :frame
    applied { false }
    player_id { 1 }
  end
end
