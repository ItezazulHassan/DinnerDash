# frozen_string_literal: true

# Controller for cartegories
class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @categories.each do |category|
      authorize category if user_signed_in?
    end
    # Need to render template
    render 'layouts/_category.html.erb'
  end

  def new
    @category = Category.new
    authorize @category if user_signed_in? && current_user.flag?
  end

  def create
    @category = Category.new(category_params)
    authorize @category if user_signed_in?
    if @category.save
      flash[:success] = 'New category Created'
      redirect_to dashboard_path
    else
      flash[:failure] = 'Error in creating category'
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category if user_signed_in? && current_user.flag?
    # Need to render template
    render template: 'categories/new'
  end

  def update
    return unless user_signed_in?

    @category = Category.find(params[:id])
    authorize @category
    if @category.update(category_params)
      flash[:success] = "#{@category.name} has been updated successfully."
      redirect_to items_path
    end
  end

  def show
    @category = Category.find(params[:id])
    # authorize @category
    # Need to render template
    @items = @category.items
    # render template: 'items/index.html.erb'
    render 'categories/_show.html.erb'
  end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
