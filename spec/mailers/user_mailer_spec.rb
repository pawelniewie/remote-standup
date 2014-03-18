require 'spec_helper'

describe UserMailer do
  describe 'reminder_mail' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.reminder_mail(user) }

    it 'renders the subject' do
      mail.subject.should == 'Hey, what have you done lately?'
    end

    it 'renders the receiver email' do
      mail.to.should == "Jessica Parker <>"
    end

    it 'renders the sender email' do
      mail.from.should == [user.reminder_inbox_email]
    end

    it 'doesn\'t render members' do
      mail.body.encoded.should_not match("reply will be forwarded to")
    end
  end

  describe 'team_update_mail' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.team_update_mail(user, []) }

    it 'renders the subject' do
      mail.subject.should == 'Hey, here\' your team update!'
    end

    it 'renders the receiver email' do
      mail.to.should == "Jessica Parker <>"
    end

    it 'renders the sender email' do
      mail.from.should == [user.reminder_inbox_email]
    end
  end
end