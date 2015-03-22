class AddTrackersToStore < ActiveRecord::Migration
  def change
  	add_column :stores, :tracker_type, :integer
  	add_column :stores, :tracker_urlidentifier, :string
  	add_column :stores, :tracker_storeurl, :string
  	add_column :stores, :tracker_baseurl, :string
  	add_column :stores, :tracker_deeplinker, :string
  	add_column :stores, :tracker_afftag, :string
  end
end
