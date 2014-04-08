require 'spec_helper'

feature 'Sign Up' do
  let(:sign_up) { SignUpPage.new }

  it 'should create an account', :js => true do
    sign_up.load
    sign_up.sign_up('pawelniewiadomski@me.com')
    page.should have_content 'Settings'
  end
end