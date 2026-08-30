class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 30 }

  has_many :records, dependent: :destroy
  has_many :theaters, dependent: :destroy
  has_many :companions, dependent: :destroy
end
