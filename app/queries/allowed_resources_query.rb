class AllowedResourcesQuery
  attr_reader :user, :relation

  def initialize(user, relation)
    @user = user
    @relation = relation
  end

  def action_on(actions)
    relation.joins(roles: %i[permissions user])
            .where(roles: {
                     permissions: {
                       access_type: actions
                     },
                     users: {
                       id: user.id
                     }
                   })
  end

  def action_on_resource(actions, resource)
    action_on(actions).where(
      resources: {
        resource_type: resource.resource_type,
        resource_id: [resource.resource_id, nil]
      }
    )
  end
end
