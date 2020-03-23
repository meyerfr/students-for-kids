class Kid < ApplicationRecord
  validates :first_name, :age, presence: true
  belongs_to :customer
end
