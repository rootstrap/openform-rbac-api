class ApplicationPolicy
  attr_reader :account, :record

  def initialize(account, record)
    @account = account
    @record = record
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  class Scope
    attr_reader :account, :scope

    def initialize(account, scope)
      @account = account
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
