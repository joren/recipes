class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @recipes = Recipe.all
    @recipes = @recipes.tagged_with(params[:tag]) if params[:tag]
    @dropped_links = DroppedLink.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

private

  def load_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :people,
      :duration,
      :instructions,
      :tag_list,
      :weight_wacthers_score,
      links_attributes: [
        :id,
        :url,
        :_destroy
      ],
      ingredient_groups_attributes: [
        :id,
        :name,
        :_destroy,
        ingredients_attributes: [
          :id,
          :name,
          :quantity,
          :_destroy
        ]
      ]
    )
  end
end
