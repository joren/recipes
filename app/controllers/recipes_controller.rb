class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show, :edit, :update, :destroy]
  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
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
      ingredient_groups_attributes: [
        :name
      ]
    )
  end
end
