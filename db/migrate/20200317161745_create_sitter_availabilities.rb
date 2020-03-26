class CreateSitterAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :sitter_availabilities do |t|
      t.references :sitter, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :booked, default: false

      t.timestamps
    end
  end
end
