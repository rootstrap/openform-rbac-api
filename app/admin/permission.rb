ActiveAdmin.register Permission do
  permit_params :access_type

  form do |f|
    f.inputs 'Details' do
      f.input :access_type
    end

    actions
  end

  index do
    selectable_column
    id_column

    column :access_type
    column :created_at

    actions
  end

  filter :id
  filter :access_type

  show do
    attributes_table do
      row :id
      row :access_type
      row :created_at
      row :updated_at
    end
  end
end
