class ContactInfo < ApplicationRecord
  validates :first_name, :last_name, :bio, presence: true
  belongs_to :sitter, optional: true
  belongs_to :customer, optional: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
