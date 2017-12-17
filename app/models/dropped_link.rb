class DroppedLink < ApplicationRecord
  validates :url, presence: true
end
