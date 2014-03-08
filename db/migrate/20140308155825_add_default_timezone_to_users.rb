class AddDefaultTimezoneToUsers < ActiveRecord::Migration
  def change
  	execute <<-SQL
  		ALTER TABLE users ALTER timezone SET DEFAULT 'GMT'
  	SQL
  	execute <<-SQL
  		UPDATE users SET timezone = 'GMT' WHERE timezone = '' OR timezone IS NULL
  	SQL
  end
end
