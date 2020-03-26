class Sitter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email
  has_one_attached :photo
  validates :age, presence: true, numericality: {greater_than: 10}, on: :update
  # validate :validate_photo, on: :update
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_one :contact_info, dependent: :destroy
  has_many :sitter_availabilities
  has_many :bookings, dependent: :destroy
  has_many :district_possibilities
  has_many :districts, through: :district_possibilities
  accepts_nested_attributes_for :district_possibilities
  has_many :customers, through: :bookings
  accepts_nested_attributes_for :contact_info#, allow_destroy: true#, reject_if: :validate_contact_info
  validates_associated :contact_info
  accepts_nested_attributes_for :sitter_availabilities, allow_destroy: true
  validates_associated :sitter_availabilities

  def with_contact_info #function is for nested forms in devise register#new
     build_contact_info if contact_info.nil?
     self
  end

  def validate_photo
    unless photo.attached?
      errors.add(:photo)
    end
  end

  private

  def send_welcome_email
    SitterMailer.welcome(self).deliver_now
  end
end
