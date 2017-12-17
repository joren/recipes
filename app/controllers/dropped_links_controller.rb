class DroppedLinksController < ApplicationController
  before_action :require_login

  def create
    DroppedLink.create!(dropped_link_params)
    redirect_to [:recipes, anchor: "dropped_links"]
  end

  private

  def dropped_link_params
    params.require(:dropped_link).permit(:url)
  end
end
