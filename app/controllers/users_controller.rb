class UsersController < ApplicationController
    before_action :check_if_admin, only: [:destroy]
    def index
        @user = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
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
            format.html { redirect_to @root_url, notice: "Could'nt find user" }
            format.json { render :show, location: @user }
            redirect_to root_path
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            format.html { redirect_to @root_url, notice: "User was successfully created." }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            format.html { redirect_to @root_url, notice: "User was successfully updated." }
            format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to root_url, notice: "User was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :username)
    end
    
    def args_params
        args = params.require(:args).permit(:show_all, :title) if params.has_key? "args"
    end
end
