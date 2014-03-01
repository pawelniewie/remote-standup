class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :from_email, {null: false, default: ''}
      t.text :from_name, {null: false, default: ''}
      t.text :headers, {array: true, null: false, default: '{}'}
      t.text :raw_payload, {null: false, default: ''}
      t.text :message_text, {null: false, default: ''}
      t.text :message_html, {null: false, default: ''}
      t.text :note, {null: false, default: ''}
      t.uuid :user_id

      t.timestamps
    end

    add_index :notes, :user_id
  end
end
