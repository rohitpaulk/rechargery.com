class AddOperatortoUsersTable < ActiveRecord::Migration
  def change
  	add_column :users, :phone_operator, :integer
  end
end
