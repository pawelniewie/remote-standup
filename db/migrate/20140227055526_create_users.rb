class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :full_name
      t.string :calling_name
      t.string :picture
      t.string :google_token
      t.timestamp :google_token_expires
      t.boolean :male

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
