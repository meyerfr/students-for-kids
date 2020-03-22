class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :contact_info
  has_many :customer_availabilities
  has_many :kids
  has_many :bookings
  has_many :sitters, through: :bookings
  accepts_nested_attributes_for :contact_info, allow_destroy: true, reject_if: proc { |att| att['first_name'].blank? }
  accepts_nested_attributes_for :customer_availabilities, allow_destroy: true
  accepts_nested_attributes_for :kids, allow_destroy: true, reject_if: proc { |att| att['first_name'].blank? }
end
