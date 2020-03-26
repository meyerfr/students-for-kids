class CreateSitterAvailabilities < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'btree_gist' unless extension_enabled?('btree_gist')
    create_table :sitter_availabilities do |t|
      t.references :sitter, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :booked, default: false

      t.timestamps
    end

    execute(
      "ALTER TABLE sitter_availabilities ADD CONSTRAINT no_overlapping_sitter_availabilities EXCLUDE USING GIST (sitter_id WITH =, tsrange(starts_at, ends_at) WITH &&)"
    )
  end
end
