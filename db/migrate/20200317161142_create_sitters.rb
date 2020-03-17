class CreateSitters < ActiveRecord::Migration[5.2]
  def change
    create_table :sitters do |t|
      t.integer :age
      t.references :contact_infos, foreign_key: true

      t.timestamps
    end
  end
end
