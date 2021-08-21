class ItemsController < ApplicationController
    before_action :check_if_admin, only: [:create, :destroy, :update, :edit_status]
    def index
        @items = Item.all.order(created_at: :asc)
    end

    def show
        @item = Item.find(params[:id])
    end

    def new
        @item = Item.new
    end

    def edit
        @item = Item.find(params[:id])
        # Need to render template
        render template: "items/new"
    end

    def create
        @item = Item.new(item_params)
        # Need to handle picture
        if @item.save
            flash[:success] = "#{@item.name} has been added successfully."
        else
            flash[:error] = "An error occured. Try adding #{@item.name} again."
        end
    end

    def update
        # Need to handle picture case here as well
        respond_to do |format|
            if @item.update_attributes(item_params)
                flash[:success] = "#{@item.name} has been updated successfully."
            else
                flash[:error] = "An error occured. Try updating #{@item.name} again."
            end
        end
    end

    def destroy
        @item.destroy
        respond_to do |format|
            flash[:success] = "#{item.name} has been deleted."
            redirect_to root_path
        end
    end
    def edit_status
        item = Item.find(item_params[:id].to_i)
        unless item.nil?
          status = item_params[:status] == true ? "available" : "not available"
          item.status = status
          item.save
          render json: item
        end
    end
    private

    def item_params
        params.require(:item).permit(:name, :description, :price, :status, :avatar)
    end

end
