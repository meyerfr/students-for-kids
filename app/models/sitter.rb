class Sitter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :contact_info
  has_many :areas
  has_many :sitter_availabilities
  has_many :customers, through: :bookings
  accepts_nested_attributes_for :contact_info, allow_destroy: true, reject_if: proc { |att| att['first_name'].blank? }
  accepts_nested_attributes_for :sitter_availabilities, allow_destroy: true
end
