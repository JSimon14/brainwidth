require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

	describe "categories#new action" do
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

	describe "categories#create action" do
		it "should require users tp be logged in" do
			post :create, category: {name: 'work'}
			expect(response).to redirect_to new_user_session_path
		end


		it "should successfully create a new task in the database" do
			user = FactoryGirl.create(:user)
			sign_in user

			post :create, category: {name: 'work'}
			expect(response).to redirect_to root_path

			category = Category.last
			expect(category.name).to eq('work')
			expect(category.user).to eq(user)
		end

		it "should properly deal with validation errors" do
			user = FactoryGirl.create(:user)
			sign_in user

			category_count = Category.count
			post :create, category: {name: ''}
			expect(response).to have_http_status(:unprocessable_entity)
			expect(category_count).to eq Category.count
		end
	end

	describe "categories#show action" do

		it "shouldn't allow a user who didn't make the category to see the category" do
			user = FactoryGirl.create(:user)
  			sign_in user
  			c = FactoryGirl.create(:category)

  			get :show, id: c.id
  			expect(response).to have_http_status(:forbidden)
		end

		it "should require user to be logged in" do
      		c = FactoryGirl.create(:category)

      		get :show, id: c.id
      		expect(response).to redirect_to new_user_session_path
    	end

	    it "should successfully show the page if the task is found" do
	        c = FactoryGirl.create(:category)
	        sign_in c.user

  		    get :show, id: c.id
  		    expect(response).to have_http_status(:success)
	    end
	    
	    it "should return a 404 error if the task is not found" do
	        user = FactoryGirl.create(:user)
			sign_in user
		
	        get :show, id: 'nopenope'
    		expect(response).to have_http_status(:not_found)
	    end
	end

	describe "categories#edit" do
		it "shouldn't allow a user who didn't make the category to edit the category" do
			user = FactoryGirl.create(:user)
  			sign_in user
  			c = FactoryGirl.create(:category)

  			get :edit, id: c.id
  			expect(response).to have_http_status(:forbidden)
		end


		it "should require user to be logged in" do
      		c = FactoryGirl.create(:category)

      		get :edit, id: c.id
      		expect(response).to redirect_to new_user_session_path
    	end

    	it "should successfully show the edit form if the gram is found" do 
			c = FactoryGirl.create(:category)
			sign_in c.user

			get :edit, id: c.id
      		expect(response).to have_http_status(:success)
    	end

    	it "should show a 404 error message if the gram is not found" do
			c = FactoryGirl.create(:category)
			sign_in c.user

			get :edit, id: "whatever"
      		expect(response).to have_http_status(:not_found)
    	end
	end 

	describe "categories#update" do

		it "shouldn't allow a user who didn't make the category to update the category" do
			c = FactoryGirl.create(:category, name: "initial value")
			user = FactoryGirl.create(:user)
  			sign_in user
  			

  			patch :update, id: c.id, category: {name: "New Value"}
  			expect(response).to have_http_status(:forbidden)
		end

		it "should require user to be logged in" do
	      	c = FactoryGirl.create(:category, name: "Initial Value")

	        patch :update, id: c.id, task: {name: "New Value"}
	      	expect(response).to redirect_to new_user_session_path
	    end

	    it "should allow users to successfully update categories" do
	        c = FactoryGirl.create(:category,  name: "Initial Value")
	        sign_in c.user

	        patch :update, id: c.id, category: {name: "New Value"}
	        expect(response).to redirect_to root_path
	        c.reload
	        expect(c.name).to eq "New Value"
	    end

	    it "should have http 404 error if the category cannot be found" do
			user = FactoryGirl.create(:user)
			sign_in user
		
			patch :update, id: "whatever", category: {name: "New Name"}
			expect(response).to have_http_status(:not_found)
	    end

	    it "should render the edit form with an http status of unprocessable_entity" do
	    	c = FactoryGirl.create(:category, name: "Initial Value")
	    	sign_in c.user

	    	patch :update, id: c.id, category: {name: ''}

	    	expect(response).to have_http_status(:unprocessable_entity)
	    	c.reload
	    	expect(c.name).to eq "Initial Value"
	    end
    end

    describe "tasks#destroy" do

    	it "shouldn't allow a user who didn't make the category to destroy the category" do
  			c = FactoryGirl.create(:category)
  			user = FactoryGirl.create(:user)
  			sign_in user

  			delete :destroy, id: c.id
  			expect(response).to have_http_status(:forbidden)
		end


    	it "should require user to be logged in" do
	      	c = FactoryGirl.create(:category)

	      	delete :destroy, id: c.id
	      	expect(response).to redirect_to new_user_session_path
	    end

    	it "should allow a user to destroy tasks" do
    		c = FactoryGirl.create(:category)
			sign_in c.user

    		delete :destroy, id: c.id

    		expect(response).to redirect_to root_path
    		c = Category.find_by_id(c.id)
    		expect(c).to eq nil
    	end

    	it "should return a 404 message if we cannot find the task with the specified id" do 
    		user = FactoryGirl.create(:user)
			sign_in user

    		delete :destroy, id: 'whatever'
    		expect(response).to have_http_status(:not_found)
    	end 
    end

end
