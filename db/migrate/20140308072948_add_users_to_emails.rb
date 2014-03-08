class AddUsersToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :sender_id, :integer
    add_column :emails, :recipient_id, :integer
  end
end
