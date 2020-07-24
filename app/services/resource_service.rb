class ResourceService
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
end
