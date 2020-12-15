# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  name       :string
#  api_key    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_api_key  (api_key) UNIQUE
#
class Account < ApplicationRecord
  before_create :generate_key
  validates :name, presence: true
  validates :api_key, uniqueness: true

  has_many :users, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :resources, dependent: :destroy

  def generate_key
    self.api_key ||= SecureRandom.urlsafe_base64(ENV.fetch('API_KEY_LENGTH').to_i { 20 })
                                 .tr('lIO0', 'sxyz')
  end
end
