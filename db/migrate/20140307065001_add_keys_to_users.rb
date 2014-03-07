class AddKeysToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_key, :text, null: false
    add_column :users, :public_key, :text, null: false
  end
end
