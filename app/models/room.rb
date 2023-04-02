class Room < ApplicationRecord
  # attr_accessor :user_id, :topic_id
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  accepts_nested_attributes_for :room_users
  has_many :messages, dependent: :destroy
  # belongs_to :topic, optional: true, dependent: :destroy

  validates  :name, presence: true
  # validates  :user_ids, presence: true

  # def save
    # topic情報を保存し、変数topicに代入する
    # @topic = Topic.create(user_id: user_ids, topic_id: @topic)
  # end
end
