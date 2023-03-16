class Topic < ApplicationRecord
  belongs_to        :user
  has_many_attached :images

  validates         :title, presence: true
  validates         :content, presence: true
  validates         :images, presence: true
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上4枚以下にしてください" }

  # validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
end
