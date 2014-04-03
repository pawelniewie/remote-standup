require 'spec_helper'

describe IncomingController do
	describe 'POST' do
		let(:user) { create(:user) }
		let(:example_payload) { mandrill_example_event('wrong_recipient') }

		it 'should sent a message when recipient is invalid' do
			IncomingMailer.should_receive(:invalid_recipient_mail).with("email@example.com", "Jimmy Bean")

			pending 'write a test here'
		end
	end
end
