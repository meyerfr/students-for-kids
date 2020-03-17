class ContractDatum < ApplicationRecord
  has_one :sitter
  has_one :customer
end
