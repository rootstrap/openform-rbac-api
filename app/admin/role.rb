ActiveAdmin.register Role do
  permit_params :name, permission_ids: []

  decorate_with RoleDecorator

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :permissions, as: :check_boxes
      f.input :resources
    end

    actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :created_at

    actions
  end

  filter :id
  filter :name

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
      row :permissions, &:permissions_string
    end
  end
end
