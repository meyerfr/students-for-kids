class CreateSitterAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :sitter_availabilities do |t|
      t.references :sitter, foreign_key: true
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
