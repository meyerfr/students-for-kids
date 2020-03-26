class ContactInfo < ApplicationRecord
  validates :first_name, :last_name, presence: true, on: :create
  validates :bio, :phone, :street, :post_code, presence: true, on: :update
  belongs_to :sitter, optional: true
  belongs_to :customer, optional: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def validate_con

  end
end
