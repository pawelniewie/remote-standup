require 'spec_helper'

describe 'Discussion' do
	context 'reminders' do
		let(:update) { create(:discussion, :with_notes, :title => Discussion.reminder_title) }
		let(:team) { create(:team, :with_user) }

		it 'should create a new discussion for each team' do
			update.notes.count.should == 3

			incoming = double('Incoming')
			expect(incoming).to receive(:from_address).and_return "sekhar@teamstatus.tv"
			expect(incoming).to receive(:from_name).and_return "Sekhar"
			expect(incoming).to receive(:headers) { { 'To' => 'sekhar@teamstatus.tv' } }
			expect(incoming).to receive(:raw).and_return ''
			expect(incoming).to receive(:message_text).and_return ''
			expect(incoming).to receive(:message_html).and_return ''
			expect(incoming).to receive(:simple_message).and_return ''

			Discussion.create_or_update_discussion team.users[0].id, incoming

			update.notes.count.should == 3
		end

	end
end