class Room < ApplicationRecord
  validates :title, presence: true
  validates :token, presence: true

  has_many :messages
  has_many :members
  has_many :users, through: :members
end
