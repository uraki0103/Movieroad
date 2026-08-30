FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "ハムナプトラ#{n}" }
    release_year { 2026 }
    poster_url { "https://example.com/poster.jpg" }
  end
end
