FactoryBot.define do
  factory :course do
    sequence(:name) { |n| "Name #{n}" }
  end
end