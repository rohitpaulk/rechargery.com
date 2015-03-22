class AddShortenersTable < ActiveRecord::Migration
  def change
  	create_table :shorteners do |t|
      t.string :in_url
      t.string :out_url      
      t.integer :http_status_code
      t.timestamps
    end
  end
end
