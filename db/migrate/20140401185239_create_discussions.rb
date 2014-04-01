class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions, id: :uuid do |t|
    	t.text :title, { null: false }
    	t.timestamps
    end
    add_column :notes, :discussion_id, :uuid
  end
end
