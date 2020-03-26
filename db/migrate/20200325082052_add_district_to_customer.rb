class AddDistrictToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :district, foreign_key: true
  end
end
