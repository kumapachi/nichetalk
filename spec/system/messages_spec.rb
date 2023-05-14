require 'rails_helper'

RSpec.describe "Messages", type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @topic = FactoryBot.create(:topic)
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @room_user = FactoryBot.create(:room_user)
  end

  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"] 
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      basic_pass root_path
      # サインインする
      sign_in(@room_user.user)
      
      # チャットルームindexへ遷移する
      visit topic_room_messages_path(@topic, @room_user.room_id)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      expect {
        find('input[name="commit"]').click
      }.not_to change { Message.count }

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(topic_room_messages_path(@topic, @room_user.room_id))

    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      visit topic_room_messages_path(@topic, @room_user.room_id)

      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message[comment]', with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(topic_room_messages_path(@topic, @room_user.room_id))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      visit topic_room_messages_path(@topic, @room_user.room_id)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(topic_room_messages_path(@topic, @room_user.room_id))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')

    end

    it 'テキストと画像の投稿に成功する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      visit topic_room_messages_path(@topic, @room_user.room_id)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message[comment]', with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')

    end
  end

end

# bundle exec rspec spec/system/messages_spec.rb
