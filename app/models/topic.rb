class Topic < ApplicationRecord
  belongs_to        :user
  has_many_attached :images
  belongs_to        :room, optional: true

  validates         :title, presence: true
  validates         :content, presence: true, presence: true, unless: :was_attached?
  validates :images, length: { maximum: 5, message: "は4枚以下にしてください" }

  # validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  def was_attached?
    self.images.attached?
  end
end
