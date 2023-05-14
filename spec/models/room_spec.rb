require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end
  describe 'roomの登録' do
    context 'roomの登録ができるとき' do
      it 'すべての入力事項が存在すれば登録できる' do
        expect(@room).to be_valid
      end
    end
    context 'roomの登録ができないとき' do
      it 'nameが空欄だと登録できない' do
        @room.name = ''
        @room.valid?
        expect(@room.errors.full_messages).to include("Name can't be blank")
      end
      it 'topicが紐付いていないと保存できない' do
        @room.topic = nil
        @room.valid?
        expect(@room.errors.full_messages).to include('Topic must exist')
      end
    end
  end
end

# bundle exec rspec spec/models/room_spec.rb