class TasksController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :show, :edit]

	def index

	end

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.create(task_params)
		if @task.valid?
			redirect_to root_path
		else
			return render :new, status: :unprocessable_entity
		end
	end

	def show
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?
	end

	def edit
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?
	end

	def update
		@task = Task.find_by_id(params[:id])
		return render_not_found if @task.blank?

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
		@task.destroy
		redirect_to root_path
	end



	private

	def task_params
		params.require(:task).permit(:title, :description, :date, :value, :category)
	end


end
