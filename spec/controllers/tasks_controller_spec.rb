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
			post :create, task: {title: 'Hello!', date: 'April 27 2016', value: '2', category: 'work'}
			expect(response).to redirect_to root_path

			task = Task.last
			expect(task.title).to eq('Hello!')
		end

		it "should properly deal with validation errors" do
			post :create, task: {title: '', date: '', value: '', category: '' }
			expect(response).to have_http_status(:unprocessable_entity)
			expect(Task.count).to eq 0 
		end
	end

end
