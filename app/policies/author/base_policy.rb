module Author
  class BasePolicy < ApplicationPolicy
    def manage?
      user.author?
    end
  end
end
