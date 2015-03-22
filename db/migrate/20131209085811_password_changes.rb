class PasswordChanges < ActiveRecord::Migration
  def change
  	add_column :users, :authmethod, :integer
  	add_column :users, :rawpass, :text
  end
end
