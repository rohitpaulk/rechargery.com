class DeleteShopnameFromOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :shopname
  end
end
