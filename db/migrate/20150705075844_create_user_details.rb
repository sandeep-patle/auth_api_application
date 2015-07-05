class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.string :mobile_number

      t.timestamps
    end
  end
end
