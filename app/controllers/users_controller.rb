class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    def index
        @user = User.all
    end

    def show

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
    
    def admin_user
        redirect_to root_url unless current_user.admin?
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to root_url unless current_user?(@user)
    end
end
