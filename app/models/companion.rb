class Companion < ApplicationRecord
  validates :companion_name, presence: true, length: { maximum: 50 }

  has_many :record_companions, dependent: :destroy
  has_many :records, through: :record_companions
  belongs_to :user
end
