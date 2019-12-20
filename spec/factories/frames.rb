# frozen_string_literal: true

FactoryBot.define do
  factory :frame do
    association :game
    number { 1 }
    bonus { 0 }
    player_id { 1 }

    trait :strike do
      ball_1 { 10 }
    end

    trait :spare do
      ball_1 { 5 }
      ball_2 { 5 }
    end

    trait :low_score do
      ball_1 { 3 }
      ball_2 { 2 }
    end
  end
end
