class Movie < ApplicationRecord
  validates :tmdb_id, uniqueness: true, allow_nil: true
  validates :title, presence: true

  has_many :records, dependent: :restrict_with_error
end
