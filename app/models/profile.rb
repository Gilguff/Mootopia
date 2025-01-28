class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  validates :bio, length: { maximum: 300 }

  def profile_picture_url
    profile_picture.present? ? profile_picture : "default-profile.png"
  end
end
