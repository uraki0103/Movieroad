class Record < ApplicationRecord
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :impression, length: { maximum: 1000 }
  validates :watched_day, presence: true
  validates :memory_note, length: { maximum: 1000 }


  belongs_to :user
  belongs_to :movie
  belongs_to :theater
  has_many :companions, through: :record_companion
  has_many :record_companions, dependent: :destroy
end
