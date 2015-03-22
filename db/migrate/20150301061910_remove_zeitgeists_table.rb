class RemoveZeitgeistsTable < ActiveRecord::Migration
  def change
    drop_table :zeitgeists
  end
end
