class FixHeadersInNotesTable < ActiveRecord::Migration
  def change
  	remove_column :notes, :headers
  	add_column :notes, :headers, :hstore, {null: false, default: ''}
  end
end
