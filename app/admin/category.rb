ActiveAdmin.register Category do
  filter :name

  # This is a hack. If the below lines aren't present - Ransack throws an error. Activeadmin problems.
  filter :stores, as: :check_boxes
  remove_filter :stores

  permit_params :name, :short_description, :long_description
end
