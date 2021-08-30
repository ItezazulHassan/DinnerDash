# frozen_string_literal: true

# Controller for orders
class OrdersController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders
  end

  def new; end

  def show
    # byebug
    @order = Order.find(params[:id])
  end

  def create; end

  def edit; end

  def update; end

  def delete; end
end
