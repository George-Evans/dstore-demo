require "rails_helper"

describe ProductsController, type: :controller do

	# index action
	context "GET #index" do
		it "renders the index page" do
			get :index
			expect(response).to be_ok
			expect(response).to render_template("index")
		end
	end

	# show action
	context "GET #show" do
		it "renders the show page" do
			@product = FactoryGirl.create(:product)
			get :show, params: {id: @product}
			expect(response).to be_ok
			expect(response).to render_template("show")
		end
	end

	# new action
	describe "GET #new" do

		context "User is admin" do
			before do
				@admin_user = FactoryGirl.create(:admin)
				sign_in @admin_user
			end

			it "renders the new page to admin" do
				get :new
				expect(response).to be_ok
			end

		end

		context "User is not admin" do
			before do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end

			it "Restricts access to new page for non-admin" do
				get :new
				expect(response).not_to be_ok
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

	end
	

	# edit action

	describe "GET #edit" do

		before do
			@product = FactoryGirl.create(:product)
		end

		context "User is admin" do
			before do
				@admin_user = FactoryGirl.create(:admin)
				sign_in @admin_user
			end

			it "renders the edit page to admin" do
				get :edit, params: {id: @product}
				expect(response).to be_ok
			end

		end

		context "User is not admin" do
			before do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end

			it "Restricts access to edit page for non-admin" do
				get :edit, params: {id: @product}
				expect(response).not_to be_ok
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

	end

	# create action
	describe "POST #create" do

		context "User is admin" do
			before do
				@admin_user = FactoryGirl.create(:admin)
				sign_in @admin_user
			end

			it "Creates a new product as admin" do
				expect {
					post :create, params: {product: attributes_for(:product)}
				}.to change(Product, :count).by(1)
				expect(response).to redirect_to product_path(assigns[:product])
				expect(flash[:notice]).to eq "Product was successfully created."
			end

		end

		context "User is not admin" do
			before do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end

			it "Cannot create a new product" do
				post :create , params: {product: attributes_for(:product)}
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

	end

	# update action


	# destroy action
	
end