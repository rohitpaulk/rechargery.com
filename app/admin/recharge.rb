ActiveAdmin.register Recharge do
	index do
		selectable_column
		column :phonenumber
		column :providertext
		column :circletext
		column :created_at
		actions
	end
  	form do |f|
		f.inputs "Recharge Details" do
			f.semantic_errors *f.object.errors.keys
			f.input :phonenumber
			f.input :circlecode
		  	f.input :operatorcode
		  	f.input :order_id
		end
		f.actions
	end
 	controller do
		def permitted_params
			params.permit recharge: [:phonenumber, :circlecode,:operatorcode,:order_id]
		end
	end
end
