ActiveAdmin.register Tracking do
	belongs_to :user, :optional => true,:parent_class => User	
	index do
		selectable_column
		column :id
		column :user
 		column :url
 		column :store
 		column :order
 		column :created_at
 		actions   	 
 	end
 	controller do
		def permitted_params
			params.permit tracking: [:user,:url]
		end
	end
end
