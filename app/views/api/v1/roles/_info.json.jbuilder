json.extract! role, :name
json.permissions role.permissions, partial: '/api/v1/permissions/info', as: :permission
