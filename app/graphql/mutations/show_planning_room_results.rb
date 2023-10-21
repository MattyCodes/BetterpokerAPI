# Flip the cards over and show the planning results to everyone in the room.
class Mutations::ShowPlanningRoomResults < Mutations::BaseMutation
  argument :planning_room_id, ID, required: true

  field :planning_room, Types::PlanningRoom, null: true
  field :error, Types::Error, null: true

  def resolve(planning_room_id:)
    room = ::PlanningRoom.find_by(uuid: planning_room_id)

    if room.nil?
      return {
        error: OpenStruct.new(
          status: 404,
          message: 'Room not found.'
        )
      }
    end

    room.update(showing_results: true)
    # TODO: Subscription stuff.
    { planning_room: room }
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
