FactoryBot.define do
  factory :user do
    email { "email@example.com" }
    password { "pass" }
    password_confirmation { "pass" }
  end
end
