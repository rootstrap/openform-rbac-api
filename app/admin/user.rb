ActiveAdmin.register User do
  permit_params :external_id, role_ids: []

  form do |f|
    f.inputs 'Details' do
      f.input :external_id
      f.input :roles, as: :check_boxes
    end

    actions
  end

  index do
    selectable_column
    id_column

    column :external_id

    actions
  end

  filter :id
  filter :external_id
  filter :created_at

  show do
    attributes_table do
      row :id
      row :external_id
      row :created_at
      row :roles
    end
  end
end
