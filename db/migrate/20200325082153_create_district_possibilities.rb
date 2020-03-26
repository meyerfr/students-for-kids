class CreateDistrictPossibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :district_possibilities do |t|
      t.references :district, foreign_key: true
      t.references :sitter, foreign_key: true

      t.timestamps
    end
  end
end
