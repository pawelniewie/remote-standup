require 'spec_helper'

describe 'Discussions' do
	context 'reminders' do
		let(:team) { create(:team, :with_user) }

		it 'should create a new discussion for each team' do
			incoming = double('Incoming')
			expect incoming to receive :from_address . and_return "sekhar@teamstatus.tv"
			Discussion.create_or_update_discussion team.users[0].id, incoming
		end

	end
end