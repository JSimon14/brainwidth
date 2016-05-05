class TasksController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]

	def index
		@categories = Category.find_by_id(params[:user_id])
		@tasks = Task.find_by_id(params[:user_id])
		@category = Category.new
		@task = Task.new
	end

	def new
		@task = Task.new
	end

	def create
		@category = Category.new
		@task = current_user.tasks.create(task_params)
		if @task.valid?
			redirect_to root_path
		else
			flash.now[:alert] = 'Unable to create task!'
			return render :index, status: :unprocessable_entity
		end
	end

	def show
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?
		return render_forbidden if @task.user != current_user
	end

	def edit
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?
		return render_forbidden if @task.user != current_user
	end

	def update
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?
		return render_forbidden if @task.user != current_user

		@task.update_attributes(task_params)
		if @task.valid?
			redirect_to root_path
		else
			return render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?
		return render_forbidden if @task.user != current_user
		@task.destroy
		redirect_to root_path
	end



	private

	def task_params
		params.require(:task).permit(:title, :description, :date, :value, :category_id)
	end


end
