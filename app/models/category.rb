# t.string :name
# t.text :short_description
# t.text :long_description
# t.timestamps

class Category < ActiveRecord::Base

	has_and_belongs_to_many :stores, join_table: :categories_stores

	validates_presence_of(:name,:message => "Category name not provided!")		

	def storestoshow
		stores.where(:status => [1,2])
	end
end
