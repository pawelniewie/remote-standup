FactoryGirl.define do
	factory :team do
		name 'Team'

    trait :with_user do
      after :create do |team|
        FactoryGirl.create :user, :team => team
      end
    end

    trait :with_jessica do
      after :create do |team|
        FactoryGirl.create :user, :team => team, :full_name => 'Jessica Parker', :email => 'jp@corp.com'
      end
    end
  end

	factory :user do
		sequence(:email) { |n| "user-#{n}@corp.com" }
		password 'abc123'
		sequence(:full_name) { |n| "User #{n}" }
		confirmed_at Time.now
		remind_on [1,2,3,4,5]

		trait :with_team do
			association :team, :factory => :team, :name => 'Team', :id => 'e5205698-bc7d-11e3-9fdb-93b32c88ce36'
		end
  end

  factory :note do
  	association :user, :factory => :user
  	association :team, :factory => :team
    note 'This is a note'
  end

	factory :discussion do
		title 'New discussion'
    association :team, :factory => [:team, :with_user], :name => 'Team', :id => 'e5205698-bc7d-11e3-9fdb-93b32c88ce36'

    trait :with_notes do
    	after :create do |discussion|
      	FactoryGirl.create_list :note, 3, :discussion => discussion, :team => discussion.team, :user => discussion.team.users[0]
    	end
    end

    trait :with_jessica do
    	after :create do |discussion|
    		FactoryGirl.create :user, :full_name => 'Jessica Parker', :email => 'jp@corp.com', :team => discussion.team
    	end
    end
	end

	trait :fixed_id do
		id '312dcfb0-bc7a-11e3-bd65-af2435c8a91b'
	end

end