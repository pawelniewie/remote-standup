class ChangeRemindOnToArrayInUsers < ActiveRecord::Migration
  def change
  	execute <<-SQL
  		ALTER TABLE users ALTER remind_on DROP DEFAULT, ALTER remind_on TYPE smallint ARRAY USING CASE WHEN remind_on='1-5' THEN ARRAY[1,2,3,4,5] WHEN remind_on='7' THEN ARRAY[1,2,3,4,5,6,7] END, ALTER remind_on SET NOT NULL
  	SQL
 		execute <<-SQL
 			ALTER TABLE users ALTER remind_on SET DEFAULT ARRAY[1::integer,2::integer,3::integer,4::integer,5::integer]
 		SQL
  	add_index :users, :remind_on, using: 'gin'
  end
end
