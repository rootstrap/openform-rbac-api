ActiveAdmin.register Resource do
  permit_params :resource_id, :resource_type

  form do |f|
    f.inputs 'Details' do
      f.input :resource_id
      f.input :resource_type
    end

    actions
  end

  index do
    selectable_column
    id_column

    column :resource_id
    column :resource_type
    column :created_at
    column :updated_at

    actions
  end

  filter :id
  filter :resource_id
  filter :resource_type

  show do
    attributes_table do
      row :id
      row :resource_id
      row :resource_type
      row :created_at
      row :updated_at
    end
  end
end
