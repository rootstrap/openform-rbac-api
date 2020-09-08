class AllowedResourcesQuery
  attr_reader :user, :relation

  def initialize(user)
    @user = user
  end

  def allowed_resources(actions, resource_type = nil)
    resources = Resource.includes(:role).where(
      roles: action_on(actions)
    )

    resource_type.present? ? resources.where(resource_type: resource_type) : resources
  end

  private

  def action_on(actions)
    Role.joins(%i[permissions user]).where(permissions: {
                                             access_type: actions
                                           },
                                           users: {
                                             id: user.id
                                           })
  end
end
