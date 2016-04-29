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





end
