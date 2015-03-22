class CreateRecharges < ActiveRecord::Migration
  def change
    create_table :recharges do |t|
      t.string :phonenumber
      t.integer :circlecode
      t.integer :operatorcode
      t.string :circletext
      t.string :operatortext		
      t.integer :amount
      t.string :txnid
      t.integer :status
      t.references :order

      t.timestamps
    end
  end
end
