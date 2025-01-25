class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: "author_id"


  # User is following
  has_many :active_following, class_name: "following", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :active_following

  # Following
  has_many :passive_following, class_name: "following", foreign_key: "followee_id", dependent: :destroy
  has_many :followees, through: :passive_following

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

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
end
