FactoryGirl.define do

	factory :recipient do
		self.alias {Faker::Name.name}
		user
	end

	factory :event do
		recipient
		name {Faker::Lorem.sentence}
		event_time DateTime.now+(365*Random.rand())
		after(:create) do |event|
			event.day = event.event_time.day
			event.month = event.event_time.month
			event.save!
		end
	end

	factory :scan do
		upc "852060003107" #mmm, beiber.
		recipient
		user
	end

	factory :user do
		password "foobar"
		email {Faker::Internet.email} 

		factory :user_with_recipients, :parent => :user do
			after(:create) do |user|
				5.times do
					FactoryGirl.create(:recipient, :user => user)
				end
			end
		end

		factory :user_with_events, :parent => :user do
			after(:create) do |user|
				5.times do
					recipient = FactoryGirl.create(:recipient, :user => user)
					3.times do
						event = FactoryGirl.create(:event, :recipient => recipient)
					end
					3.times do
						FactoryGirl.create(:scan, :recipient => recipient, :user => user)
					end
				end
			end
		end
	end
end


