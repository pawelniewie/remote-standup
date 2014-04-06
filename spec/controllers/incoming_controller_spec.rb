require 'spec_helper'

describe IncomingController do

  describe 'create' do

		context 'invalid data' do
      it 'should reject a message when recipient is invalid' do
        message = double('Message')
        IncomingMailer.should_receive(:invalid_recipient_mail).with("from@example.com", "inbox@example.com").and_return(message)
        message.should_receive(:deliver)

        post :create, :mandrill_events => [ mandrill_example_event('wrong_recipient') ].to_json, format: :json
      end

			it 'should reject a message when recipient is not in the team' do
				message = double('Message')
				IncomingMailer.should_receive(:not_belongs_mail).with("pawel@corp.com").and_return(message)
				message.should_receive(:deliver)

				post :create, :mandrill_events => [ mandrill_example_event('unknown_sender') ].to_json, format: :json
      end

      it 'should reject a message when recipient is unknown' do
        message = double('Message')
        IncomingMailer.should_receive(:invalid_recipient_mail).with("pawel@corp.com", "reminder-e5205698-bc7d-11e3-9fdb-93b32c88ce36@in.remotestandup.com").and_return(message)
        message.should_receive(:deliver)

        post :create, :mandrill_events => [ mandrill_example_event('unknown_reminder') ].to_json, format: :json
      end

      it 'should reject a message when recipient is unknown' do
        message = double('Message')
        IncomingMailer.should_receive(:invalid_recipient_mail).with("pawel@corp.com", "discussion-e5205698-bc7d-11e3-9fdb-93b32c88ce36@in.remotestandup.com").and_return(message)
        message.should_receive(:deliver)

        post :create, :mandrill_events => [ mandrill_example_event('unknown_sender_discussion') ].to_json, format: :json
      end

      it 'should reject a message when discussion is unknown' do
        create(:user)

        message = double('Message')
        IncomingMailer.should_receive(:invalid_discussion_mail).with("jp@corp.com", "discussion-e5205698-bc7d-11e3-9fdb-93b32c88ce36@in.remotestandup.com").and_return(message)
        message.should_receive(:deliver)

        post :create, :mandrill_events => [ mandrill_example_event('unknown_discussion') ].to_json, format: :json
      end

    end

		context 'valid data' do

      it 'should create a new discussion' do
        create(:team, :fixed_id, :with_user).id.should == '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'

				IncomingMailer.should_not_receive(:invalid_recipient_mail)

				post :create, :mandrill_events => [ mandrill_example_event('team_recipient') ].to_json, format: :json
				expect(response).to be_ok

				Discussion.last.title.should == 'test 2 with attachment'
			end

			it 'should create a new discussion for an incoming reminder' do
        create(:user, :fixed_id, :team => create(:team)).id.should == '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'

				post :create, :mandrill_events => [ mandrill_example_event('reminder') ].to_json, format: :json
				expect(response).to be_ok

				Discussion.last.title.should == 'Team Update from ' + Time.now.to_s(:year_month_day)
			end

      it 'should add a note to an existing discussion' do
        create(:discussion, :fixed_id).id.should == '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'

        Discussion.last.notes.count.should == 0

        IncomingMailer.should_not_receive(:invalid_recipient_mail)

        post :create, :mandrill_events => [ mandrill_example_event('discussion') ].to_json, format: :json
        expect(response).to be_ok

        Discussion.last.title.should == 'New discussion'
        Discussion.last.notes.count.should == 1
      end

    end
  end
end
