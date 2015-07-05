class AddIndexesToColumns < ActiveRecord::Migration
  def change
    add_index :users, :email
  end
end
