class Link < ActiveRecord::Base
  belongs_to :recipe

  def image?
    url =~ /\.(jpe?g|gif|png)$/i
  end
end
