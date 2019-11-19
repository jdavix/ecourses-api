FactoryBot.define do
  factory :content do
    sequence(:title) { |n| "Name #{n}" }
    content_type { ['pdf', 'audio', 'music', 'download'].sample }
  end
end