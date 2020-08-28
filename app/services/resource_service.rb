class ResourceService
  attr_reader :resource_type, :resource_id

  def initialize(resource_type, resource_id)
    @resource_type = resource_type
    @resource_id = resource_id
  end

  def resource
    Resource.find_or_create_by!(resource_type: @resource_type, resource_id: @resource_id)
  end

  def matching_resources
    @matching_resources ||= Resource.matching(resource_id: @resource_id,
                                              resource_type: @resource_type)
  end

  def action_on_resource?(user, actions)
    AllowedResourcesQuery.new(user)
                         .allowed_resources(actions, resource_type)
                         .matching(resource_type: resource.resource_type,
                                   resource_id: resource.resource_id)
                         .any?
  end
end
