FactoryBot.define do
  factory :game do
    player_1 { "MyString" }
    player_2 { "MyString" }
    current_player { 1 }
    current_frame { 1 }
  end
end
