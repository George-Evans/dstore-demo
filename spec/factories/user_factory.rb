FactoryGirl.define do
	sequence(:email) { |n| "spec-test-user#{n}@example.com" }

	factory :user do
		email
		password "testpassword"
		first_name "Rosalie"
		last_name "Tester"
		admin false

		factory :admin do
			first_name "Admin"
			last_name "User"
			admin true
		end
	end
end