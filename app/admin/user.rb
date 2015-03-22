ActiveAdmin.register User do
	index do
		selectable_column
		column :name
 		column :email
 		column :orderscount
 		column :authmethod
 		column :last_login
 		column :created_at
 		actions
 	end
 	controller do
		def permitted_params
			params.permit user: [:name, :email, :phone, :auth_method, :phone_operator]
		end
	end
	sidebar "Resources", only: [:show, :edit] do
	    ul do
	        li link_to("Trackings", admin_user_trackings_path(user))
	        li link_to("Orders", admin_user_orders_path(user))
	    end
	end

end
