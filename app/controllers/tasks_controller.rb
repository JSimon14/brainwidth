class TasksController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :show]

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



	private

	def task_params
		params.require(:task).permit(:title, :description, :date, :value, :category)
	end


end
