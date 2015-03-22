class AddUrLandStoretoTracking < ActiveRecord::Migration
  def change
  	add_column :trackings,:finalurl,:string 
  	add_column :trackings,:store_id,:integer
  end
end
