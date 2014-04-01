class LinkNotesToDiscussions < ActiveRecord::Migration
  def change
  	add_index :discussions, :team_id
  	add_index :notes, :discussion_id

  	execute <<-SQL
  		UPDATE notes n SET discussion_id = (SELECT id FROM discussions d WHERE d.created_at::date = n.created_at::date AND d.team_id = n.team_id)
  	SQL
  end
end
