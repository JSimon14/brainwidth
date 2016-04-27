require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	describe "tasks#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "tasks#new action" do
		it "should successfully show the new form" do
			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "tasks#create action" do
		it "should successfully create a new task in the database" do
			post :create, task: {title: 'Hello!'}
			expect(response).to redirect_to root_path

			task = Task.last
			expect(task.title).to eq('Hello!')
		end
	end

end
