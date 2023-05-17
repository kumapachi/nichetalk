class Message < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  belongs_to :room

  has_one_attached :image

  validates  :comment, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end
end
