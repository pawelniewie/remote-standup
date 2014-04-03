require 'spec_helper'

describe IncomingMailer do
  describe 'invalid_recipient_mail' do
    let(:user) { create(:user) }
    let(:recipient_email) { 'team-1f32b674-9de9-435c-9bbf-42751d6b7e31@in.remotestandup.com' }
    let(:to_address) { 'pawel@example.com' }
    let(:mail) { IncomingMailer.invalid_recipient_mail(to_address, recipient_email) }

    it 'renders the subject' do
      mail.should have_subject 'Sorry, but there\'s no such inbox :-('
    end

    it 'renders the receiver email' do
      mail.should deliver_to to_address
    end

    it 'renders the sender email' do
      mail.from.should == ['pawel@remotestandup.com']
    end

    it 'includes the recipient email' do
      mail.should have_body_text recipient_email
    end
  end
end