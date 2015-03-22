class AddStoretoOrders < ActiveRecord::Migration
  def change
  	add_column :orders,:store_id,:integer
  end
end
