ActiveAdmin.register Store do
    filter :categories, as: :check_boxes
    filter :name
    filter :status
    
  	permit_params do
      params = []
      params.push :name, :short_desc, :long_desc,:status,:image_name, category_ids: []
      params.push :tracking_reliability,:adblock_compatibility,:payment_method
      params.push :tracker_type,:tracker_urlidentifier,:tracker_storeurl,:tracker_baseurl,:tracker_deeplinker,:tracker_afftag
      params
    end
  	index do
			selectable_column
			column :id
			column :name
			column :status
			actions   	 
		end

  	form do |f|
			f.inputs "Store Details" do
				f.input :name
        f.input :status, as: :select, collection:  Store.statuskeys
        f.input :categories, as: :check_boxes, collection: Category.all
				f.input :image_name
				f.input :short_desc
				f.input :long_desc								
        f.input :tracking_reliability
        f.input :adblock_compatibility
        f.input :payment_method
			end
      f.inputs "Tracker Details" do
        f.input :tracker_type, as: :select, collection: Store.trackertypes
        f.input :tracker_urlidentifier
        f.input :tracker_storeurl
        f.input :tracker_baseurl
        f.input :tracker_deeplinker
        f.input :tracker_afftag
      end
			f.actions
		end

		show do |store|
      attributes_table do
        row :name
        row :status
        row :short_desc
        row :long_desc
        row "image" do
          image_tag(asset_url("stores/#{store.image_name}"))
        end
        row :tracking_reliability
        row :adblock_compatibility
        row :payment_method
        row "Categories" do
        	store.categories.each do |category|
        		div link_to(category.name,admin_category_path(category))
        	end
        end        
      end
      attributes_table do
        row :tracker_type
        row :tracker_urlidentifier        
        row :tracker_storeurl
        row :tracker_baseurl        
        row :tracker_deeplinker
        row :tracker_afftag        
      end
      active_admin_comments
    end
end
