class DeleteProviderTextfromRecharges < ActiveRecord::Migration
  def change
  	remove_column :recharges, :operatortext
  	remove_column :recharges, :circletext
  end
end
