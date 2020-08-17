# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  resource_id :bigint
#
# Indexes
#
#  index_roles_on_resource_id  (resource_id)
#  index_roles_on_user_id      (user_id)
#
require 'rails_helper'

RSpec.describe Role, type: :model do
end
