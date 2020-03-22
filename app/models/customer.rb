class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many_attached :photos
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :contact_info
  has_many :customer_availabilities
  has_many :kids
  has_many :bookings
  has_many :sitters, through: :bookings
  accepts_nested_attributes_for :contact_info, allow_destroy: true, reject_if: proc { |att| att['first_name'].blank? }
end
