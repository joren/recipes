class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.text :instructions, null: false
      t.integer :people, default: 1
      t.integer :duration, default: 1

      t.timestamps null: false
    end
  end
end
