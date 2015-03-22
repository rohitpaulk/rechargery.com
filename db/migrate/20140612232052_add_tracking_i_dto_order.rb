class AddTrackingIDtoOrder < ActiveRecord::Migration
  def change
  	add_column :orders,:tracking_id,:integer
  end
end
