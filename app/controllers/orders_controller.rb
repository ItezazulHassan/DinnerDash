# frozen_string_literal: true

# Controller for orders
class OrdersController < ApplicationController
  def index
    redirect_to root_path unless user_signed_in?
    begin
      @user = User.find(params[:user_id])
      @orders = @user.orders
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
      flash[:failure] = "User not found"
      nil
    end
  end

  def new; end

  def show
    # byebug
    begin
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
      flash[:failure] = "Order not found"
      return
    end
  end

  def create; end

  def edit; end

  def update; end

  def delete; end
end
