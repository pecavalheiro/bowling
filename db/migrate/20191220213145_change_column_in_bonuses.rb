class ChangeColumnInBonuses < ActiveRecord::Migration[6.0]
  def change
    remove_column :bonuses, :applied
    add_column :bonuses, :throws_to_sum, :integer
  end
end
