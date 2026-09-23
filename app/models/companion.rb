class Companion < ApplicationRecord
  validates :companion_name, presence: true, length: { maximum: 50 }

  has_many :record_companions, dependent: :destroy
  has_many :records, through: :record_companions
  belongs_to :user

  def self.find_or_create_all_for(user, names)
    names.reject(&:blank?).uniq.map { |name| user.companions.find_or_create_by(companion_name: name) }
  end
end
