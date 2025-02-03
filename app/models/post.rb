class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates :body, presence: true, length: { maximum: 500 }

  # Likes
  has_many :likings, dependent: :destroy
  has_many :likers, through: :likings, source: :user

  # Comments
  has_many :comments, dependent: :destroy
end
