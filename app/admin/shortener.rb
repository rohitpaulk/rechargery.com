ActiveAdmin.register Shortener do

  index do
    selectable_column
    column :finallink
    column :out_url
    column :created_at
    actions      
  end

  controller do
    def permitted_params
      params.permit shortener: [:in_url,:out_url,:http_status_code]
    end
  end
end
