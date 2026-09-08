class Theater < ApplicationRecord
  validates :theater_name, presence: true, length: { maximum: 50 }

  belongs_to :user
  has_many :records, dependent: :nullify

  def self.find_or_create_for(user, theater_name)
    user.theaters.find_or_create_by(theater_name: theater_name)
  end
end
