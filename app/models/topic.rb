class Topic < ApplicationRecord
  belongs_to        :user
  has_many_attached :images
  has_one           :room, dependent: :destroy
  has_many          :messages, dependent: :destroy

  validates         :title, presence: true
  validates         :content, presence: true
  validates :images, length: { maximum: 4, message: "は4枚以下にしてください" }

  # validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  # def was_attached?
    # self.images.attached?
  # end
end
