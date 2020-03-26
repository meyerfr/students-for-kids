class CreateCustomerAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_availabilities do |t|
      t.references :customer, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :booked, default: false

      t.timestamps
    end
  end
end
