FactoryBot.define do
  factory :task do
		title { "first_title" }
		content { "first_content" }
		status { "todo" }
		deadline { DateTime.now }
  end
end
