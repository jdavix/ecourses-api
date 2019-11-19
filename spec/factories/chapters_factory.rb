FactoryBot.define do
  factory :chapter do
    sequence(:title) { |n| "Name #{n}" }
  end
end