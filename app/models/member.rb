class Member < ApplicationRecord
  validates :user, presence: true
  validates :room, presence: true

  belongs_to :user
  belongs_to :room
end
