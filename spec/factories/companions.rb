FactoryBot.define do
  factory :companion do
    sequence(:companion_name) { |n| "友達くん#{n}" }
    association :user
  end
end
