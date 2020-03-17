class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.references :contact_infos, foreign_key: true

      t.timestamps
    end
  end
end
