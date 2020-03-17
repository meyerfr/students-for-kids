class ContractDatum < ApplicationRecord
  has_one :sitter, :customer
end
