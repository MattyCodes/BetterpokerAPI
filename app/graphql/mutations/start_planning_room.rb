# Start a new planning room with the specified name.
class Mutations::StartPlanningRoom < Mutations::BaseMutation
  argument :name, String, required: true

  field :planning_room, Types::PlanningRoom, null: true
  field :error, Types::Error, null: true

  def resolve(name:)
    { planning_room: ::PlanningRoom.create(name: name) }
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
