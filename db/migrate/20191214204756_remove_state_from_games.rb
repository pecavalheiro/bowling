# frozen_string_literal: true

class RemoveStateFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :state, :string
  end
end
