require 'spec_helper'

feature 'Sign Up page' do
  let(:sign_up) { SignUpPage.new }

  it 'should create an account', :js => true do
    sign_up.load
    sign_up.sign_up('pawelniewiadomski@me.com')
    page.should have_content 'Settings'
  end

  context 'login links' do
  	it 'should be there' do
  		sign_up.load
  		sign_up.should have_providers
  		sign_up.providers.map { |link| link.text } == ["Github", "Google Oauth2", "Asana"]
  	end
	end
end