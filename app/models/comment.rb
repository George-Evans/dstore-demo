class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :summary, presence: true
  validates :body, presence: true
	validates :user, presence: true
	validates :product, presence: true
	validates :rating, numericality: { only_integer: true }

  after_create_commit {CommentUpdateJob.perform_later(self, @user)}

  scope :rating_desc, -> { order(rating: :desc) }
  scope :rating_asc, -> { order(rating: :asc) }
  scope :most_recent, -> {order(created_at: :desc)}

end
