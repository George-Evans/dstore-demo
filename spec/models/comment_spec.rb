require 'rails_helper'

describe Comment do
	
	context "when comment has no summary" do
		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, body: "test", rating: 5)
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment has no body" do

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, summary: "test summary", rating: 5)
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment has no user" do

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(summary: "test summary", body: "test", rating: 5)
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment has no product" do

		it "is not valid" do
			user = FactoryGirl.build(:user)
			comment = Comment.new(user: user, summary: "test summary", body: "test", rating: 5)
			expect(comment).not_to be_valid
		end

	end

	context "when comment has no rating" do

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, summary: "test summary", body: "test")
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment rating is not a number" do

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, summary: "test summary", body: "test", rating: "great")
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment rating is more that 5" do

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, summary: "test summary", body: "test", rating: "10")
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment rating is a negative number" 

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, summary: "test summary", body: "test", rating: "-5")
		end

		it "is not valid" do
			expect(product.comments.first).not_to be_valid
		end

	end

	context "when comment has all necessary fields" do

		product = FactoryGirl.build(:product)
		user = FactoryGirl.build(:user)

		before do
			product.comments.new(user: user, summary: "test summary", body: "test", rating: "5")
		end

		it "is valid" do
			expect(product.comments.first).to be_valid
		end

	end