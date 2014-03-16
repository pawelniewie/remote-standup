class AddSentTeamUpdateAtToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :sent_team_update_at, :timestamp
  end
end
