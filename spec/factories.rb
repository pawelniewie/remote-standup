FactoryGirl.define do
	factory :team do
		name 'Team'
	end

	factory :user do
		email "jp@corp.com"
		password 'abc123'
		full_name "Jessica Parker"
		confirmed_at Time.now
		remind_on [1,2,3,4,5]
		association :team, :factory => :team, :name => 'Team', :id => 'e5205698-bc7d-11e3-9fdb-93b32c88ce36'
	end

	trait :fixed_id do
		id '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'
	end

	factory :board do
		name "Testing board"
	end
end