ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do

    column :id
    column :first_name
    column :last_name
    column :email
    tag_column :role, interactive: true
    # tag_column :status, interactive: true       
    column :image
    column :created_at
    column :updated_at
    actions
  end

  show do
  attributes_table do
    tag_row :role
  end
end

    filter :id
    filter :first_name
    filter :last_name
    filter :email
    filter :role
    filter :image
    filter :created_at
    filter :updated_at
end
