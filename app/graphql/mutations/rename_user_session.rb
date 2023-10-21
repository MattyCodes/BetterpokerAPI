# Give an existing user session a new name.
class Mutations::RenameUserSession < Mutations::BaseMutation
  argument :name, String, required: true
  argument :user_session_id, ID, required: true

  field :user_session, Types::UserSession, null: true
  field :error, Types::Error, null: true

  def resolve(name:, user_session_id:)
    session = ::UserSession.find_by(uuid: user_session_id)

    if session.nil?
      return {
        error: OpenStruct.new(
          status: 404,
          message: 'Session not found.'
        )
      }
    end

    session.update(name: name)
    # TODO: Subscription stuff.
    # MySchema.subscriptions.trigger(:post_added, { param1: :value }, OpenStruct.new)
    { user_session: session }
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
