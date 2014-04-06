FactoryGirl.define do
	factory :team do
		name 'Team'

    trait :with_user do
      after :create do |team|
        FactoryGirl.create :user, :team => team
      end
    end

  end

	factory :user do
		email "jp@corp.com"
		password 'abc123'
		full_name "Jessica Parker"
		confirmed_at Time.now
		remind_on [1,2,3,4,5]
  end

	factory :discussion do
		title 'New discussion'
    association :team, :factory => [:team, :with_user], :name => 'Team', :id => 'e5205698-bc7d-11e3-9fdb-93b32c88ce36'
	end

	trait :fixed_id do
		id '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'
	end

end