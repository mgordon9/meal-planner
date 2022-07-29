class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.belongs_to :schedule
      t.timestamps
    end
  end
end
