class Types::PlanningRoom < BaseObject
  field :id, ID
  field :name, String
  field :showing_results, Boolean
  field :user_sessions, [Types::UserSession]

  def id
    object.uuid
  end
end
