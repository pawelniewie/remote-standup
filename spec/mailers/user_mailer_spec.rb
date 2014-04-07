require 'spec_helper'

describe UserMailer do
  describe 'reminder_mail' do
    let(:user) { create(:user, :with_team) }
    let(:mail) { UserMailer.reminder_mail(user) }

    it 'renders the subject' do
      mail.should have_subject 'Hey, what have you done lately?'
    end

    it 'renders the receiver email' do
      mail.should deliver_to 'Jessica Parker <jp@corp.com>'
    end

    it 'renders the sender email' do
      mail.from.should == [user.reminder_inbox_email]
    end

    it 'doesn\'t render members' do
      mail.should_not have_body_text "reply will be forwarded to"
    end
  end

  describe 'team_update_mail' do
    let(:user) { create(:user, :with_team) }
    let(:mail) { UserMailer.team_update_mail(user, []) }

    it 'renders the subject' do
      mail.should have_subject 'Hey, here\'s your team update!'
    end

    it 'renders the receiver email' do
      mail.should deliver_to 'Jessica Parker <jp@corp.com>'
    end

    it 'renders the sender email' do
      mail.from.should == [user.reminder_inbox_email]
    end
  end
end