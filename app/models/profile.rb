class Profile < ApplicationRecord
  belongs_to :user
  validates :bio, length: { maximum: 3000 }

  def profile_picture_url
    profile_picture.present? ? profile_picture : "default-profile.png"
  end
end
