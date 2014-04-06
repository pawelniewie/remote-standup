require 'spec_helper'

describe IncomingController do
	context 'team target' do
		let(:user) { create(:user, :fixed_id) }
		let(:team) { user.team }
		let(:example_payload) { mandrill_example_event('wrong_recipient') }

		context 'invalid data' do

			it 'should reject a message when recipient is invalid' do
				message = double('Message')
				IncomingMailer.should_receive(:invalid_recipient_mail).with("from@example.com", "inbox@example.com").and_return(message)
				message.should_receive(:deliver)

				post :create, :mandrill_events => [ example_payload ].to_json, format: :json
			end

			it 'should reject a message when recipient is not in the team' do
				user.id.should == '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'
				user.team.id.should == 'e5205698-bc7d-11e3-9fdb-93b32c88ce36'

				message = double('Message')
				IncomingMailer.should_receive(:not_belongs_mail).with("pawel@corp.com").and_return(message)
				message.should_receive(:deliver)

				post :create, :mandrill_events => [ mandrill_example_event('unknown_sender') ].to_json, format: :json
			end
		end

		context 'valid data' do

			it 'should create a new discussion when recipient is team' do
				user.id.should == '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'
				user.team.id.should == 'e5205698-bc7d-11e3-9fdb-93b32c88ce36'

				post :create, :mandrill_events => [ mandrill_example_event('team_recipient') ].to_json, format: :json
				expect(response).to be_ok

				Discussion.last.title.should == 'test 2 with attachment'
			end

		end
	end
end
