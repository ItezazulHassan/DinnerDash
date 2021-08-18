class ItemsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :user_is_admin, only: [:create, :edit, :update, :destroy]
    def index
        redirect_to root_url
    end

    def show

    end

    def new
        @item = Item.new
    end

    def edit

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

    private

    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.require(:item).permit(:name, :description, :price)
    end
end
