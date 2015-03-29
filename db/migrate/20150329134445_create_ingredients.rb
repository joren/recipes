class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :quantity
      t.belongs_to :ingredient_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
