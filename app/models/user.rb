class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: "author_id"
  has_many :comments, dependent: :destroy, foreign_key: "author_id"


  # User is following
  has_many :active_following, class_name: "following", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :active_following

  # Following
  has_many :passive_following, class_name: "following", foreign_key: "followee_id", dependent: :destroy
  has_many :followees, through: :passive_following

  # Likes
  has_many :likings, dependent: :destroy
  has_many :liked_posts, through: :likings, source: :post

  def like(post)
    liked_posts << post unless liked?(post)
  end

  def unlike(post)
    liked_posts.delete(post)
  end

  def liked?(post)
    liked_posts.include?(post)
  end

  # Profile
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
end
