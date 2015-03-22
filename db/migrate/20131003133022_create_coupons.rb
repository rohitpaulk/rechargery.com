class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :amount
      t.string :txnid
      t.integer :status
      t.references :order
      
      t.timestamps
    end
  end
end
