class Following < ApplicationRecord
  belongs_to :followee
  belongs_to :follower
end
