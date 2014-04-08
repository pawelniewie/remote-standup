class SignUpPage < SitePrism::Page
  set_url '/users/sign_up'

  def sign_up(email)
    within '#new_user' do
      fill_in 'Email', with: email
      fill_in 'Password', with: 'password'
      click_on 'Sign up'
    end
  end
end