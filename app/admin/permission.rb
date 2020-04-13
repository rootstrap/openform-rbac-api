ActiveAdmin.register Permission do
  permit_params :access_type, :resource_id

  form do |f|
    f.inputs 'Details' do
      f.input :access_type
      f.input :resource, collection: Resource.resource_strings
    end

    actions
  end

  index do
    selectable_column
    id_column

    column :access_type
    column :created_at
    column :resource

    actions
  end

  filter :id
  filter :access_type

  show do
    attributes_table do
      row :id
      row :access_type
      row :resource
      row :created_at
      row :updated_at
    end
  end
end
