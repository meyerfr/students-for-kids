class District < ApplicationRecord
  has_many :customers
  has_many :district_possibilities
  has_many :sitters, through: :district_possibilities
end
