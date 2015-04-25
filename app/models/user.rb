class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :recipes

  def to_s
    email
  end
end
