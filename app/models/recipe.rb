class Recipe < ActiveRecord::Base
  acts_as_taggable

  validates :name, presence: true
  validates :people, presence: true
  validates :duration, presence: true
  validates :instructions, presence: true

  belongs_to :user

  has_many :ingredient_groups, dependent: :destroy
  has_many :links, dependent: :destroy

  accepts_nested_attributes_for :ingredient_groups, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
end
