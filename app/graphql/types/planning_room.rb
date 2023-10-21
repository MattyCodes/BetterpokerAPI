class Types::PlanningRoom < BaseObject
  field :id, ID
  field :name, String
  field :user_sessions, [Types::UserSession]

  def id
    object.uuid
  end
end
