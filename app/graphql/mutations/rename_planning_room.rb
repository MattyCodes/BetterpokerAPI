# Give an existing planning room a new name.
class Mutations::RenamePlanningRoom < Mutations::BaseMutation
  argument :name, String, required: true
  argument :planning_room_id, ID, required: true

  field :planning_room, Types::PlanningRoom, null: true
  field :error, Types::Error, null: true

  def resolve(name:, planning_room_id:)
    room = ::PlanningRoom.find_by(uuid: planning_room_id)

    if room.nil?
      return {
        error: OpenStruct.new(
          status: 404,
          message: 'Room not found.'
        )
      }
    end

    room.update(name: name)
    # TODO: Subscription stuff.
    # MySchema.subscriptions.trigger(:post_added, { param1: :value }, OpenStruct.new)
    { planning_room: room }
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
