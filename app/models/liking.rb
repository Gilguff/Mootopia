class Liking < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: { scope: :post_id, message: "you can only like a post once" }
end
