class AddTokenToNotes < ActiveRecord::Migration
	class Note < ActiveRecord::Base
		include Tokenable
  end

  def change
  	add_column :notes, :token, :text

  	Note.all.each do |note|
  		note.save
  	end

  	change_column :notes, :token, :text, { null: false }
  	add_index :notes, :token, unique: true
  end
end
