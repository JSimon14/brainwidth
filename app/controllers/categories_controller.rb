class CategoriesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]

	def new
		@category = Category.new
	end

	def create
		@task = Task.new
		@category = current_user.categories.create(category_params)
		if @category.valid?
			redirect_to root_path
		else
			flash.now[:alert] = 'Unable to create category!'
			return render "tasks/index", status: :unprocessable_entity
		end
	end

	def show
		@category = Category.find_by_id(params[:id])
		return render_not_found if @category.blank?
		return render_forbidden if @category.user != current_user
	end

	def edit
		@category = Category.find_by_id(params[:id])
		return render_not_found if @category.blank?
		return render_forbidden if @category.user != current_user
	end

	def update
		@category = Category.find_by_id(params[:id])
		return render_not_found if @category.blank?
		return render_forbidden if @category.user != current_user

		@category.update_attributes(category_params)
		if @category.valid?
			redirect_to root_path
		else
			return render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@category = Category.find_by_id(params[:id])
		return render_not_found if @category.blank?
		return render_forbidden if @category.user != current_user
		@category.destroy
		redirect_to root_path
	end


	private

	def category_params
		params.require(:category).permit(:name, :description)
	end

end
