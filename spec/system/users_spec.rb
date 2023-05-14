require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Users", type: :system do

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    basic_pass root_path

    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('ログイン/新規登録')

    # サインインページへ移動する
    # visit  new_user_session_path
    find('a[class= "login"]').click

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'email1', with: @user.email
    fill_in 'password1', with: @user.password

    # ログインボタンをクリックする
    click_on('commit')

    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)

    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('ログイン/新規登録')
  end


end

# bundle exec rspec spec/system/users_spec.rb