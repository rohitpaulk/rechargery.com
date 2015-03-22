class CreateZeitgeists < ActiveRecord::Migration
  def change
    create_table :zeitgeists do |t|
      t.string :name
      t.string :email
      t.string :college
      t.integer :theme
      t.text :caption
      t.string :photo_url
      t.timestamps
    end
  end
end
