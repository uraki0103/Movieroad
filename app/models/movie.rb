class Movie < ApplicationRecord
  validates :tmdb_id, uniqueness: true, allow_nil: true
  validates :title, presence: true

  has_many :records, dependent: :restrict_with_error

  def self.find_or_create_for(title)
    find_or_create_by(title: title)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.find_or_create_for(title:, tmdb_id: nil, release_year: nil, poster_url: nil)
    if tmdb_id.present?
      movie = find_or_initialize_by(tmdb_id: tmdb_id)
      movie.title = title
      movie.release_year = release_year if release_year.present?
      movie.poster_url = poster_url if poster_url.present?
      movie.save
      movie
    else
      find_or_create_by(title: title)
    end
  end
end
