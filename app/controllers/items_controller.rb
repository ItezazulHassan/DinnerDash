# frozen_string_literal: true

class ItemsController < ApplicationController
  # before_action :check_if_admin, only: [:create, :destroy, :update, :edit_status]
  def index
    @items = policy_scope(Item).all.order(created_at: :asc)
    @categories = Category.all
    @item_categories = ItemCategory.all
    @user = User.find(@current_user.id) if user_signed_in?
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(@current_user.id) if user_signed_in?
  end

  def new
    @item = Item.new
    if user_signed_in?
      if current_user.flag?
        @categories = Category.all
        authorize @item
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
    if user_signed_in?
      if current_user.flag?
        authorize @item
      end

      # Need to render template
      #render template: 'items/new'
    end
  end

  def create
    @item = Item.new(item_params)
    # @item_category = ItemCategory.new(item_id: @item.id, category_id: params[:id])
    # @item.item_categories << ItemCategory.create(item_id: @item.id, category_id: params[:item][:category_ids])

    # Need to handle picture
    if user_signed_in?
      authorize @item

      if @item.save
        # @item_category.save

        # byebug
        @item_category = ItemCategory.new(item_id: @item.id, category_id: params[:item][:category_ids])
        @item_category.save
        redirect_to items_path
        flash[:success] = "#{@item.name} has been added successfully."
      else
        flash[:error] = "An error occured. Try adding #{@item.name} again."
      end
    end
  end

  def update
    # Need to handle picture case here as well
    if user_signed_in?
      @item = Item.find(params[:id])
      authorize @item

      if @item.update(item_params)
        @item_categories = @item.item_categories
        @item_categories.update(category_id: params[:item][:category_ids])
        flash[:success] = "#{@item.name} has been updated successfully."
        redirect_to items_path
      else
        flash[:error] = "An error occured. Try updating #{@item.name} again."
      end
    end
  end

  def destroy
    if user_signed_in?
      authorize @item
      @item.destroy
      respond_to do |_format|
        flash[:success] = "#{item.name} has been deleted."
        redirect_to root_path
      end
    end
  end

  def edit_status
    # byebug
    item = Item.find(params[:item_id].to_i)
    unless item.nil?
      flag = item_params[:flag] == "true" ? false : true
      #byebug
      item.flag = flag
      item.save
      redirect_to items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :flag, :avatar)
  end
end
