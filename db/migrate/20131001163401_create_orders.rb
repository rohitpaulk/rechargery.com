class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :shopname
      t.string :orderid
      t.string :productname
      t.integer :status
      t.integer :shopstatus

      t.references :user
      t.timestamps
    end
  end
end
