class Room < ApplicationRecord
  has_many   :users
  # belongs_to :topic, optional: true
  has_many   :messages, dependent: :destroy

  validates :name, presence: true
end
