require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	describe "tasks#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "tasks#new action" do
		it "should require users tp be logged in" do
			get :new
			expect(response).to redirect_to new_user_session_path
		end

		it "should successfully show the new form" do
			user = User.create(
				email: 'fakeemail@yahoo.com',
				password: 'fakepassword',
				password_confirmation: 'fakepassword'
				)
			sign_in user

			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "tasks#create action" do
		it "should require users tp be logged in" do
			post :create, task: {title: 'Hello!', date: 'April 27 2016', value: '2', category: 'work'}
			expect(response).to redirect_to new_user_session_path
		end


		it "should successfully create a new task in the database" do
			user = User.create(
				email: 'fakeemail@yahoo.com',
				password: 'fakepassword',
				password_confirmation: 'fakepassword'
				)
			sign_in user

			post :create, task: {title: 'Hello!', date: 'April 27 2016', value: '2', category: 'work'}
			expect(response).to redirect_to root_path

			task = Task.last
			expect(task.title).to eq('Hello!')
			expect(task.user).to eq(user)
		end

		it "should properly deal with validation errors" do
			user = User.create(
				email: 'fakeemail@yahoo.com',
				password: 'fakepassword',
				password_confirmation: 'fakepassword'
				)
			sign_in user

			task_count = Task.count
			post :create, task: {title: '', date: '', value: '', category: '' }
			expect(response).to have_http_status(:unprocessable_entity)
			expect(task_count).to eq Task.count
		end
	end

end
