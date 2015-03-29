class IngredientGroup < ActiveRecord::Base
  belongs_to :recipe
  has_many :ingredients, dependent: :destroy

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
