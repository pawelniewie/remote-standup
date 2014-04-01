class CreateDiscussionsFromNotes < ActiveRecord::Migration
  def change
  	add_column :discussions, :team_id, :uuid

    execute <<-SQL
    	INSERT INTO discussions (team_id, title, created_at, updated_at) (
		    WITH summary AS (
		    SELECT n.created_at::date as title,
		           n.team_id,
		           n.created_at,
		           n.updated_at,
		           ROW_NUMBER() OVER(PARTITION BY n.team_id, n.created_at::date
		                                 ORDER BY n.created_at DESC) AS rk
		      FROM notes n)
				SELECT s.team_id, 'Team Update from ' || s.title, s.created_at, s.updated_at
				  FROM summary s
				 WHERE s.rk = 1
			)
    SQL
  end
end
