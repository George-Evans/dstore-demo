require 'rails_helper'

describe Product do

	context "when product has comments" do
		let (:product) { Product.create!(name: "Spec Test Product", description: "Test", price: 22.5)}
		let (:user) {User.create!(email: "spec@test.com", password: "spectest")}

		before do
			product.comments.create!(rating: 1, user: user, summary: "terrible!", body: "test")
			product.comments.create!(rating: 3, user: user, summary: "not bad!", body: "test")
			product.comments.create!(rating: 5, user: user, summary: "great!", body: "test")
		end

		it "returns the average rating of all comments" do
			expect(product.average_rating).to eq 3
		end

		it "returns the highest rated comment" do
			expect(product.highest_rating_comment.rating).to eq 5
		end

		it "returns the lowest rated comment" do
			expect(product.lowest_rating_comment.rating).to eq 1
		end

		it "is not valid if name is blank" do
			expect(Product.new(description: "Product without a name", price: 1.5)).not_to be_valid
		end

		it "is not valid without a price" do
			expect(Product.new(name: "No Price Product", description: "Product without price")).not_to be_valid
		end

		it "is not valid when the price is not a number" do
			expect(Product.new(name: "Non-number Price Product", description: "Product without a numerical price", price: "five")).not_to be_valid
		end

	end

	context "when product has no comments" do

		let (:product) { Product.create!(name: "Spec Test Product", description: "Test", price: 22.5)}
		let (:user) {User.create!(email: "spec@test.com", password: "spectest")}

		it "has comments" do
			expect(product.comments).not_to exist
		end

		it "returns the average rating of all comments" do
			expect(product.average_rating).to eq 0
		end

	end
	
end