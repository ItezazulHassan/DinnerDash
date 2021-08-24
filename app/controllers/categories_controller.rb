class CategoriesController < ApplicationController
    def index
        @categories = Category.all
        @categories.each do |category|
            authorize category
        end
        # Need to render template
        render "layouts/_category.html.erb"
    end

    def new
        @category = Category.new
        authorize @category
    end

    def create
        @category = Category.new(category_params)
        authorize @category
        if @category.save
            flash[:success] = "New category Created"
            redirect_to dashboard_path
        else
            flash[:failure] = "Error in creating category"
        end
    end
    
    def edit
        @category = Category.find(params[:id])
        authorize @category
        # Need to render template
        render template: "categories/new"
    end

    def show
        @category = Category.find(params[:id])
        authorize @category
        # Need to render template
        render template: 'items/index.html.erb'
    end

    def destroy

    end
    
    private
    
    def category_params
        params.require(:category).permit(:name)
    end
end
