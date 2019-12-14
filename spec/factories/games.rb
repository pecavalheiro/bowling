FactoryBot.define do
  factory :game do
    player1 { "MyString" }
    player2 { "MyString" }
    state { "running" }
    current_player { 1 }
    current_frame { 1 }
  end
end
