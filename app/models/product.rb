class Product < ApplicationRecord
	has_many :orders
	has_many :comments

	validates :name, presence: true
	validates :price, presence: true, numericality: true

	def self.search(search_term)
		if Rails.env.production?
			Product.where("name ilike ?", "%#{search_term}%")
		else
			Product.where("name LIKE ?", "%#{search_term}%")
		end
	end

	def highest_rating_comment
		comments.rating_desc.first
	end

	def lowest_rating_comment
		comments.rating_asc.first
	end

	def average_rating
		comments.average(:rating).to_f
	end

	def views
		$redis.get("product:#{id}")
	end

	def viewed!
		$redis.incr("product:#{id}")
	end

	def set_latest_reviewer(user_name)
		$redis.set("latest_reviewer_product:#{id}", "#{user_name}")
	end

	def get_latest_reviewer
		$redis.get("latest_reviewer_product:#{id}")
	end

end
	