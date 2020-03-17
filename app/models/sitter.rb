class Sitter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :contact_info
  has_many :areas
  has_many :sitter_availabilities
  has_many :customers, through: :bookings
end
