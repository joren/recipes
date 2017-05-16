class AddWeightWatchersScoreToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :weight_wacthers_score, :integer, default: 0
  end
end
