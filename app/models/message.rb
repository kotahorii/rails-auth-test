class Message < ApplicationRecord
  validates :content, presence: true
  validates :room, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :room
end
