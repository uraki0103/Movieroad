FactoryBot.define do
  factory :record do
    rating { 5.0 }
    watched_day { Time.current }
    association :user
    association :movie

    trait :with_theater do
      theater { association :theater, user: user }
    end

    trait :with_companion do
      after(:create) do |record|
        companion = create(:companion, user: record.user)
        create(:record_companion, record: record, companion: companion)
      end
    end
  end
end
