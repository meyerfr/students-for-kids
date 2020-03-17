class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :customer, foreign_key: true
      t.references :sitter, foreign_key: true
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
