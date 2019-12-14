class FixDatabaseColumnNaming < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :player1, :player_1
    rename_column :games, :player2, :player_2
    rename_column :frames, :player, :player_id
  end
end
