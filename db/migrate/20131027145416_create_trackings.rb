class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
    	t.string :url
    	t.references :user
    	t.timestamps
    end
  end
end
