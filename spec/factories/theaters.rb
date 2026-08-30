FactoryBot.define do
  factory :theater do
    sequence(:theater_name) { |n| "#{n}シネマズ" }
    association :user
  end
end
