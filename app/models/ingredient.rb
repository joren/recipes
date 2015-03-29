class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_group

  validates :name, presence: true
  validates :quantity, presence: true
end
