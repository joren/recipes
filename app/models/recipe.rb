class Recipe < ActiveRecord::Base
  validates :name, presence: true
  validates :people, presence: true
  validates :duration, presence: true
  validates :instructions, presence: true

  has_many :ingredient_groups

  accepts_nested_attributes_for :ingredient_groups
end
