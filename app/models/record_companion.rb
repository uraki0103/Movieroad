class RecordCompanion < ApplicationRecord
  validates :record_id, uniqueness: { scope: :companion_id }

  belongs_to :record
  belongs_to :companion
end
