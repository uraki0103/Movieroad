FactoryBot.define do
  factory :record_companion do
    transient do
      user { create(:user) }
    end

    record { association :record, user: user }
    companion { association :companion, user: user }
  end
end
