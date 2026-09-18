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
end
