class CreateCategoriesAndStores < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :short_description
      t.text :long_description
      t.timestamps
    end

    create_table :stores do |t|
      t.string :name
      t.string :image_name
      t.text :short_desc
      t.text :long_desc
      t.integer :status
      t.integer :tracking_reliability
      t.boolean :adblock_compatibility
      t.integer :payment_method
      t.timestamps
    end

    create_table :categories_stores, id: false do |t|
      t.belongs_to :category
      t.belongs_to :store
    end
  end
end
