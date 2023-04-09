class Message < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :user
  belongs_to :room

  # has_many_attached :images
  has_one_attached :image

  # validates  :images, presence: true
  validates  :comment, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end
  # validates  :images, length: { minimum: 1, maximum: 1, message: "は1枚以下にしてください" }

  # def was_attached?
    # self.images.attached?
  # end
end
