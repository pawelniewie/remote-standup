class DropMembersFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :members
  end
end
