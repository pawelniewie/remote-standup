class SignUpPage
  include Capybara::DSL

  def visit_page
    visit '/users/sign_up'
    self
  end

  def sign_up(email)
    fill_in 'email', with: email
    fill_in 'password', with: 'password'
    click_on 'Sign Up'
  end
end