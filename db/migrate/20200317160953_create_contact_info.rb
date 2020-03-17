class CreateContactInfo < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_infos do |t|
      t.string :street
      t.string :post_code
      t.string :city
      t.string :country
      t.string :phone
      t.text :bio
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
