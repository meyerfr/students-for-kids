class CreateKids < ActiveRecord::Migration[5.2]
  def change
    create_table :kids do |t|
      t.references :customer, foreign_key: true
      t.integer :age
      t.string :first_name

      t.timestamps
    end
  end
end
