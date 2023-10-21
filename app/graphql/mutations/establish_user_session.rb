# Create a new user session, tied to the specified planning room.
class Mutations::EstablishUserSession < Mutations::BaseMutation
  argument :name, String, required: true
  argument :room_id, ID, required: true

  field :user_session, Types::UserSession, null: true
  field :error, Types::Error, null: true

  def resolve(name:, room_id:)
    room = ::PlanningRoom.find_by(uuid: room_id)

    return OpenStruct.new(status: 404, message: 'Room not found.') if room.nil?

    # If nobody is in the room, then the first one in gets to be the owner.
    user_session = ::UserSession.create(
      name: name,
      planning_room: room,
      owner: room.user_sessions.count.zero?
    )

    { user_session: user_session }
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
