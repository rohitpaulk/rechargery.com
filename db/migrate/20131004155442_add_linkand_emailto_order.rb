class AddLinkandEmailtoOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :emailused, :string
  end
end
