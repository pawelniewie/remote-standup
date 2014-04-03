require 'spec_helper'

describe IncomingController do
	describe 'POST' do
		let(:user) { create(:user) }
		let(:example_payload) { mandrill_example_event('wrong_recipient') }

		it 'should sent a message when recipient is invalid' do
			message = mock('Message')
			IncomingMailer.should_receive(:invalid_recipient_mail).with("from@example.com", "inbox@example.com").and_return(message)
			message.should_receive(:deliver)

			post :create, :mandrill_events => [ example_payload ].to_json, format: :json
		end
	end
end
