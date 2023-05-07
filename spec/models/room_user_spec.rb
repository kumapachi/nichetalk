require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  before do
    @room_user = FactoryBot.build(:room_user)
  end
  context 'room_userが機能しないとき' do
    it 'roomが紐付いていないと保存できない' do
      @room_user.room = nil
      @room_user.valid?
      expect(@room_user.errors.full_messages).to include('Room must exist')
    end
    it 'userが紐付いていないと保存できない' do
      @room_user.user = nil
      @room_user.valid?
      expect(@room_user.errors.full_messages).to include('User must exist')
    end
  end
end

# bundle exec rspec spec/models/room_user_spec.rb