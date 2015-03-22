ActiveAdmin.register Order do
  belongs_to :user, :optional => true,:parent_class => User
  #belongs_to :tracking, :optional => true,:parent_class => Tracking

	scope :pending
  scope :confirmed
	scope :completed
	scope :failed
	index do
		selectable_column
		column "Rechargery ID", :id
  	column :store
  	column :user
  	column :amount
  	column "Status", :statustext
 		column :created_at
 		column :recharge
    column :tracking
 		actions
 	end

  form do |f|
    f.inputs "Order Details" do
      f.input :store, as: :select, collection: Store.all
      f.input :status, as: :select, collection:  Order.statuskeys
      f.input :user_id
      f.input :tracking_id
      f.input :amount
      f.input :orderid
      f.input :productname
      f.input :emailused
      f.input :ordertotal
    end
    f.actions
  end

 	controller do
    	def permitted_params
      		params.permit order: [:orderid,:productname,:status,:user_id,:amount,:emailused,:ordertotal,:store_id,:tracking_id]
    	end
  end
  sidebar "Resources", only: [:show, :edit] do
    ul do
      li link_to("Trackings", admin_user_trackings_path(order.user))
      li link_to("Other Orders", admin_user_orders_path(order.user))
    end
  end
end
