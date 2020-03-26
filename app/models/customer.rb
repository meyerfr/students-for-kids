class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email
  has_one_attached :photo
  # validate :validate_photo, on: :update
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_one :contact_info
  has_many :customer_availabilities
  belongs_to :district, optional: true
  accepts_nested_attributes_for :district
  has_many :kids
  has_many :bookings
  has_many :sitters, through: :bookings
  accepts_nested_attributes_for :contact_info, allow_destroy: true#, reject_if: proc { |att| att['first_name'].blank? }
  validates_associated :contact_info
  accepts_nested_attributes_for :customer_availabilities, allow_destroy: true
  validates_associated :customer_availabilities
  accepts_nested_attributes_for :kids, allow_destroy: true#, reject_if: proc { |att| att['first_name'].blank? }
  validates_associated :kids

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
    CustomerMailer.welcome(self).deliver_now
  end
end
