module SignInSupport
  def sign_in(user)
    visit root_path
    find('a[class= "login"]').click
    fill_in 'email1', with: @user.email
    fill_in 'password1', with: @user.password
    click_on('commit')
    expect(current_path).to eq(root_path)
  end
end