ActiveAdmin.register Resource do
  permit_params :name, :resource_id

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :resource_id, as: :number, label: 'Resource ID'
    end

    actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :resource_id
    column :created_at

    actions
  end

  filter :id
  filter :name
  filter :resource_id

  show do
    attributes_table do
      row :id
      row :name
      row :resource_id
      row :created_at
      row :updated_at
    end
  end
end
