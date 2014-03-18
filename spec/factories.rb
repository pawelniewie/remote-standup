FactoryGirl.define do
	factory :user do
		email "jp@corp.com"
		password 'abc123'
		full_name "Jessica Parker"
		remind_on [1,2,3,4,5]
	end

	factory :board do
		name "Testing board"
	end
end