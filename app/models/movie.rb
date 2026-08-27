class Movie < ApplicationRecord
  validates :tmdb_id, presence: true, uniqueness: true
  validates :title, presence: true

  has_many :records, dependent: :restrict_with_error
end
