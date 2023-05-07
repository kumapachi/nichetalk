require 'rails_helper'

RSpec.describe Topic, type: :model do
  before do
    @topic = FactoryBot.build(:topic)
  end
  describe 'topicの登録' do
    context 'topicの登録ができるとき' do
      it 'すべての入力事項が存在すれば登録できる' do
        expect(@topic).to be_valid
      end
      it 'contentが空でも保存できる' do
        @topic.content = ''
        expect(@topic).to be_valid
      end
      it 'imagesが空でも保存できる' do
        @topic.images = nil
        expect(@topic).to be_valid
      end
      it '画像が複数でも投稿できる' do
        @topic.images = [ fixture_file_upload('public/images/test_image.png', 'test_image.png'),
                          fixture_file_upload('public/images/test_image.png', 'test_image.png') ]
        expect(@topic).to be_valid
      end
    end
    context 'topicの登録ができないとき' do
      it 'titleが空欄だと登録できない' do
        @topic.title = ''
        @topic.valid?
        expect(@topic.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentとimagesが空欄だと登録できない' do
        @topic.content = ''
        @topic.images = nil
        @topic.valid?
        expect(@topic.errors.full_messages).to include("Content can't be blank")
      end
      it '画像が5枚以上でだと投稿できない' do
        @topic.images = [ fixture_file_upload('public/images/test_image.png', 'test_image.png'), 
                          fixture_file_upload('public/images/test_image.png', 'test_image.png'),
                          fixture_file_upload('public/images/test_image.png', 'test_image.png'),
                          fixture_file_upload('public/images/test_image.png', 'test_image.png'),
                          fixture_file_upload('public/images/test_image.png', 'test_image.png') ]
        @topic.valid?
        expect(@topic.errors.full_messages).to include('Images は4枚以下にしてください')
      end
      it 'userが紐付いていないと保存できない' do
        @topic.user = nil
        @topic.valid?
        expect(@topic.errors.full_messages).to include('User must exist')
      end
    end
  end
end

# bundle exec rspec spec/models/topic_spec.rb