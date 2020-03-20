class ContactInfo < ApplicationRecord
  belongs_to :sitter, optional: true
  belongs_to :customer, optional: true
end
