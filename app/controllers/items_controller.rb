class ItemsController < ApplicationController
    # before_action :check_if_admin, only: [:create, :destroy, :update, :edit_status]
    def index
        @items = Item.all.order(created_at: :asc)
        @categories = Category.all
        @item_categories = ItemCategory.all
    end

    def show
        @item = Item.find(params[:id])
    end

    def new
        @item = Item.new
        @categories = Category.all
        authorize @item
    end

    def edit
        @item = Item.find(params[:id])
        authorize @item
        # Need to render template
        render template: "items/new"
    end

    def create
        @item = Item.new(item_params)
        # @item_category = ItemCategory.new(item_id: @item.id, category_id: params[:id])
        # @item.item_categories << ItemCategory.create(item_id: @item.id, category_id: params[:item][:category_ids])
         
        # Need to handle picture
        authorize @item
        if @item.save
            # @item_category.save
            
            # byebug
            @item_category = ItemCategory.new(item_id: @item.id, category_id: params[:item][:category_ids])
            @item_category.save
            flash[:success] = "#{@item.name} has been added successfully."
        else
            flash[:error] = "An error occured. Try adding #{@item.name} again."
        end
    end

    def update
        # Need to handle picture case here as well
        authorize @item
        respond_to do |format|
            if @item.update_attributes(item_params)
                flash[:success] = "#{@item.name} has been updated successfully."
            else
                flash[:error] = "An error occured. Try updating #{@item.name} again."
            end
        end
    end

    def destroy
        authorize @item
        @item.destroy
        respond_to do |format|
            flash[:success] = "#{item.name} has been deleted."
            redirect_to root_path
        end
    end
    def edit_status
        item = Item.find(item_params[:id].to_i)
        unless item.nil?
          flag = item_params[:flag] == true ? "available" : "not available"
          item.flag = flag
          item.save
          render json: item
        end
    end
    private

    def item_params
        params.require(:item).permit(:name, :description, :price, :flag, :avatar)
    end

end
