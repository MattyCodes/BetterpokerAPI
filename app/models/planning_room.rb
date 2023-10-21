# A planning room - basically just a way of grouping user
# sessions so that everybody is casting votes in the same space.
class PlanningRoom < ApplicationRecord
  include ModelHelpers::Uuid

  has_many :user_sessions, dependent: :destroy
end
