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
			user = FactoryGirl.create(:user)
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
			user = FactoryGirl.create(:user)
			sign_in user

			post :create, task: {title: 'Hello!', date: 'April 27 2016', value: '2', category: 'work'}
			expect(response).to redirect_to root_path

			task = Task.last
			expect(task.title).to eq('Hello!')
			expect(task.user).to eq(user)
		end

		it "should properly deal with validation errors" do
			user = FactoryGirl.create(:user)
			sign_in user

			task_count = Task.count
			post :create, task: {title: '', date: '', value: '', category: '' }
			expect(response).to have_http_status(:unprocessable_entity)
			expect(task_count).to eq Task.count
		end
	end

	describe "tasks#show action" do
		it "should require user to be logged in" do
      		task = FactoryGirl.create(:task)
      		get :show, id: task.id
      		expect(response).to redirect_to new_user_session_path
    	end

	    it "should successfully show the page if the task is found" do
	        user = FactoryGirl.create(:user)
			sign_in user

	        task = FactoryGirl.create(:task)
  		    get :show, id: task.id
  		    expect(response).to have_http_status(:success)
	    end
	    
	    it "should return a 404 error if the task is not found" do
	        user = FactoryGirl.create(:user)
			sign_in user

	        get :show, id: 'nopenope'
    		expect(response).to have_http_status(:not_found)
	    end

  end

end
