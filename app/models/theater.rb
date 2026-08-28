class Theater < ApplicationRecord
  validates :theater_name, presence: ture, length: { maximum: 50 }

  belongs_to :user
  has_many :records, dependent: :nullify
end
