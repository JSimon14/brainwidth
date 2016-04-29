class CategoriesController < ApplicationController
	before_action :authenticate_user!, only: [:new]

	def new
		@category = Category.new
	end
end
