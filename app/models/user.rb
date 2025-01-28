class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # Posts
  has_many :posts, dependent: :destroy, foreign_key: "author_id"
  has_many :comments, dependent: :destroy, foreign_key: "author_id"


  # Following
  has_many :active_followings, class_name: "Following", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_followings, source: :followed

  has_many :passive_followings, class_name: "Following", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_followings, source: :follower


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

  def total_likes
    posts.joins(:likings).count
  end

  # Profile
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
end
