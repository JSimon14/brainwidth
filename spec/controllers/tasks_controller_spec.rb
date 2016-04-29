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

	describe "tasks#edit" do
		it "should require user to be logged in" do
      		task = FactoryGirl.create(:task)
      		get :edit, id: task.id
      		expect(response).to redirect_to new_user_session_path
    	end

    	it "should successfully show the edit form if the gram is found" do 
			task = FactoryGirl.create(:task)
			sign_in task.user

			get :edit, id: task.id
      		expect(response).to have_http_status(:success)
    	end

    	it "should show a 404 error message if the gram is not found" do
			task = FactoryGirl.create(:task)
			sign_in task.user

			get :edit, id: "whatever"
      		expect(response).to have_http_status(:not_found)
    	end
	end 

	describe "tasks#update" do
	    it "should allow users to successfully update tasks" do
	        p = FactoryGirl.create(:task, title: "Initial Value")
	        patch :update, id: p.id, task: {title: "New Value"}
	        expect(response).to redirect_to root_path
	        p.reload
	        expect(p.title).to eq "New Value"
	    end

	    it "should have http 404 error if the task cannot be found" do
			patch :update, id:"whatever", task: {title: "New Title"}
			expect(response).to have_http_status(:not_found)
	    end

	    it "should render the edit form with an http status of unprocessable_entity" do
	    	p = FactoryGirl.create(:task, title: "Initial Value")
	    	patch :update, id: p.id, task: {title: ''}

	    	expect(response).to have_http_status(:unprocessable_entity)
	    	p.reload
	    	expect(p.title).to eq "Initial Value"
	    end
    end

    describe "tasks#destroy" do
    	it "should allow a user to destroy tasks" do
    		p = FactoryGirl.create(:task)
    		delete :destroy, id: p.id

    		expect(response).to redirect_to root_path
    		p = Task.find_by_id(p.id)
    		expect(p).to eq nil
    	end

    	it "should return a 404 message if we cannot find the task with the specified id" do 
    		delete :destroy, id: 'whatever'
    		expect(response).to have_http_status(:not_found)
    	end 
    end

end








