# frozen_string_literal: true

# Controller for users
class UsersController < ApplicationController
  before_action :check_if_admin, only: [:destroy]
  def index
    @user = User.all
  end

  def show
    begin
      @user = User.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
      flash[:failure] = "User not found"
      return
    end
    args = args_params || {}
    if @user
      if !args.nil?
        @orders = @user.orders
        @title = args[:title] || "Profile"
      else
        @orders = @user.orders.order(created_at: :desc).limit(3)
        @title = "Recent Orders"
      end
    else
      flash[:message] = "We're sorry we couldn't find any information for this user."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{user_params[:name]} to dinner dash!"
      redirect to root_url
    else
      flash[:error] = "One or more required fields are missing"
      render "new"
    end
  end

  def edit
    redirect_to root_path unless user_signed_in?
    @user = User.find(params[:id])
  end

  def update
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
      flash[:failure] = "User not found"
      return
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Successfully Updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    respond_to do |_format|
      flash[:success] = "#{user.name} has been deleted."
      redirect_to dashboard_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :encrypted_password, :username)
    end

    def args_params
      params.require(:args).permit(:show_all, :title) if params.has_key? "args"
    end
end
