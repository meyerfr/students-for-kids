class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.integer :sign_in_count, default: 0
      t.datetime :last_sign_in

      t.timestamps
    end
  end
end
