class AdministratorController < ApplicationController
  # before_action :check_if_admin, only: [:show, :update]
  # def index
  #     if user_signed_in?
  #         @user = User.where(id: current_user.id).take!
  #     end
  # end
  def show
    if user_signed_in?
      @user = User.where(id: current_user.id).take!
      @orders = Order.all.paginate(page: params[:page], per_page: 10)
    end
  end

  def item_index
    @items = Item.all.order(created_at: :desc)
    respond_to do |format|
      format.html { render :"administrator/show_item" }
    end
  end

  def order_index
    @orders = Order.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html { render :"administrator/show_order" }
    end
  end

  def user_index
    @users = User.all.paginate(page: params[:page],
                               per_page: 10).order(created_at: :desc)
    respond_to do |format|
      format.html { render :"administrator/show_user" }
    end
  end

  def category_index
    @categories = Category.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html { render :"administrator/show_category" }
    end
  end

  def update
    @title = 'orders'
    @orders = Order.all.paginate(page: params[:page], per_page: 10)
    @status = params['order']['status']
    @order_id = params['order_id']
    @order = Order.find(@order_id)
    @order.update(status: @status)
    redirect_to dashboard_path
  end

  def check_if_admin
    if admin?
      true
    else
      redirect_to root_path
      flash[:danger] = 'You do not have access to the Admin page'
    end
  end
end
