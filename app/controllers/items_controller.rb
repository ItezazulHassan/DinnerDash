class ItemsController < ApplicationController
    before_action :check_if_admin, only: [:create, :destroy, :update, :edit_status]
    def index
        @foods = Food.all.order(created_at: :asc)
    end

    def show
        @food = Food.find(params[:id])
    end

    def new
        @item = Item.new
    end

    def edit
        @food = Food.find(params[:id])
        # Need to render template
        # render template: "items/new"
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            format.html { redirect_to @item, notice: 'Item was successfully created.' }
            format.json { render :show, status: :created, location: @item }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @item.errors, status: :unprocessable_entity }
        end
    end

    def update
        respond_to do |format|
            if @item.update_attributes(item_params)
                format.html { redirect_to @item, notice: "Item was successfully updated." }
                format.json { render :show, status: :ok, location: @item }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @item.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @item.destroy
        respond_to do |format|
            format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
            format.json { head :no_content }
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
        params.require(:item).permit(:name, :description, :price, :status)
    end

end
