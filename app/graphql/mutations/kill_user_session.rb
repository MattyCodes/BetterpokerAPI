# Delete the specified user session from the database, and remove them
# from their designated planning room.
class Mutations::KillUserSession < Mutations::BaseMutation
  argument :user_session_id, ID, required: true

  field :error, Types::Error, null: true

  def resolve(user_session_id:)
    session = ::UserSession.find_by(uuid: user_session_id)

    if session.nil?
      return {
        error: OpenStruct.new(
          status: 404,
          message: 'Session not found.'
        )
      }
    end

    session.destroy
    # TODO: Subscription stuff.
    # MySchema.subscriptions.trigger(:post_added, { param1: :value }, OpenStruct.new)
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
