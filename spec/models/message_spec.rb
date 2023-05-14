require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  describe 'messageの登録' do
    context 'messageの登録ができるとき' do
      it 'すべての入力事項が存在すれば登録できる' do
        expect(@message).to be_valid
      end
      it 'imageが空でも保存できる' do
        @message.image = nil
        expect(@message).to be_valid
      end
    end
    context 'messageの登録ができないとき' do
      it 'commentが空欄だと登録できない' do
        @message.comment = ''
        @message.valid?
        expect(@message.errors.full_messages).to include("Comment can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('User must exist')
      end
      it 'roomが紐付いていないと保存できない' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Room must exist')
      end
    end
  end
end

# bundle exec rspec spec/models/message_spec.rb