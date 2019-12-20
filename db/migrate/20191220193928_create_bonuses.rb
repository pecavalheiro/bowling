class CreateBonuses < ActiveRecord::Migration[6.0]
  def change
    create_table :bonuses do |t|
      t.references :frame, null: false, foreign_key: true
      t.integer :player_id
      t.boolean :applied, default: false

      t.timestamps
    end
  end
end
