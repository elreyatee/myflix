class CategoriesController < ApplicationController
  before_action :require_user
  
  def show
    @category = Category.find_by(name: params[:name])
  end
end