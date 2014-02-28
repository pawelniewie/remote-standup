class AddBasicSettingsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :timezone, :text, { null: false, default: 'GMT' }
  	add_column :users, :reminder_at_h, :smallint, { null: false, default: 17 }
  	add_column :users, :reminder_at_m, :smallint, { null: false, default: 0 }
  	add_column :users, :remind_on, :text, { null: false, default: '1-5' }
  	add_column :users, :members, :text, { array: true, default: '{}', null: false }
  end
end
