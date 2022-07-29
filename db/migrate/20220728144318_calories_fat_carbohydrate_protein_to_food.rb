class CaloriesFatCarbohydrateProteinToFood < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :calories, :decimal
    add_column :foods, :fat, :decimal
    add_column :foods, :carbohydrates, :decimal
    add_column :foods, :protein, :decimal
    add_column :foods, :fat_secret_food_id, :int
  end
end
