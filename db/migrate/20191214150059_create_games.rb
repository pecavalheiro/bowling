# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :player1
      t.string :player2
      t.string :state, default: 'running'
      t.integer :current_player, default: 1
      t.integer :current_frame, default: 1

      t.timestamps
    end
  end
end
