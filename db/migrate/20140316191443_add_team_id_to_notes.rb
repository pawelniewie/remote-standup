class AddTeamIdToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :team_id, :uuid
  	execute <<-SQL
  		UPDATE notes SET team_id = (SELECT team_id FROM users WHERE id = user_id)
  	SQL
  	add_index :notes, :team_id
  end
end
