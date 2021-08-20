class CategoriesController < ApplicationController
    def index
        @categories = Category.all
        # Need to render template
        # render "/app/views/layouts/_category.html.erb"
    end

    def new
        @category = Category.new
    end

    def create
        if admin?
            @category = Category.new(category_params)
            if @category.save
                format.html { redirect_to root_path, notice: 'Category was successfully created.' }
                format.json { render :show, status: :created, location: @category }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def edit
        @category = Category.find(params[:id])
        # Need to render template
        # render template: "categories/new"
    end

    def show
        @category = Category.find(params[:id])
        # Need to render template
        # render template: 'items/index.html.erb'
    end

    def destroy

    end
    
    private
    
    def category_params
        params.require(:category).permit(:title)
    end
end
