class AddGameToBonuses < ActiveRecord::Migration[6.0]
  def change
    add_reference :bonuses, :game, null: false, foreign_key: true
  end
end
