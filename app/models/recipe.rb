class Recipe < ActiveRecord::Base
  validates :name, presence: true
  validates :people, presence: true
  validates :duration, presence: true
  validates :instructions, presence: true
end
