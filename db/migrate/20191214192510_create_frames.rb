class CreateFrames < ActiveRecord::Migration[6.0]
  def change
    create_table :frames do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :number
      t.integer :ball_1
      t.integer :ball_2
      t.integer :ball_extra
      t.integer :player
      t.integer :bonus, default: 0

      t.timestamps
    end
  end
end
