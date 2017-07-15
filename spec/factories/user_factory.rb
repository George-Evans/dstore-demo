FactoryGirl.define do
	sequence(:email) { |n| "specuser#{n}@example.com" }

	factory :user do
		email
		password "testpassword"
		first_name "Rosalie"
		last_name "Tester"
		admin false
	end
end