class ResourceService
  attr_reader :account, :resource_type, :resource_id

  def initialize(account = nil, resource_type = nil, resource_id = nil)
    @account = account
    @resource_type = resource_type
    @resource_id = resource_id
  end

  def find_or_create_by!(account, resource_type, resource_id)
    Resource.find_or_create_by!(account_id: account.id,
                                resource_type: resource_type,
                                resource_id: resource_id)
  end
end
