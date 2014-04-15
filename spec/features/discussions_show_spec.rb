require 'spec_helper'

feature 'Discussion\'s notes view' do
	let(:show) { DiscussionsShowPage.new }

	let(:discussion) { create(:discussion, :with_notes) }

  before { login_as discussion.notes[0].user }

  it 'should highligth Updates in menu' do
    show.load discussion_id: discussion.id
    show.current_url.should include "/discussions/#{discussion.id}/notes"
    page.should have_content 'Notes'
    show.menu.should have_active_item
  end
end