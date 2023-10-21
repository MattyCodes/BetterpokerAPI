# Just kidding, I'm taking my vote back!
class Mutations::RescindVote < Mutations::BaseMutation
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

    session.update(vote: nil)
    # TODO: Subscription stuff.
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
