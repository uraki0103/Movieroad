class Record < ApplicationRecord
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :impression, length: { maximum: 1000 }
  validates :watched_day, presence: true
  validates :memory_note, length: { maximum: 1000 }
  validate :theater_belongs_to_same_user

  belongs_to :user
  belongs_to :movie
  belongs_to :theater, optional: true
  has_many :record_companions, dependent: :destroy
  has_many :companions, through: :record_companions
  has_many_attached :memory_photos

  private

  def theater_belongs_to_same_user
    return if theater.blank?
    return if user_id == theater.user_id

    errors.add(:theater, "は記録の作成者と同じユーザーである必要があります")
  end
end
