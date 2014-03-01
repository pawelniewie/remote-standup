class AddSentReminderAt < ActiveRecord::Migration
  def change
  	add_column :users, :sent_reminder_at, :timestamp
  end
end
