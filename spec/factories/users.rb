FactoryBot.define do
  factory :user do
    email { "email@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
	factory :another_user, class: User do
    email { "another_email@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
