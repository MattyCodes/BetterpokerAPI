class Types::UserSession < BaseObject
  field :id, ID
  field :name, String
  field :vote, [Types::VoteOption]
  field :owner, Boolean

  def id
    object.uuid
  end
end
