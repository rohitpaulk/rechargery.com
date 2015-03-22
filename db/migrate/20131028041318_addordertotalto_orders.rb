class AddordertotaltoOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :ordertotal, :integer
  end
end
