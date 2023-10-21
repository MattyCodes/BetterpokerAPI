# As a user in a planning room, cast your vote!
class Mutations::CastVote < Mutations::BaseMutation
  argument :vote, Types::VoteOption, required: true
  argument :user_session_id, ID, required: true

  field :error, Types::Error, null: true

  def resolve(vote:, user_session_id:)
    session = ::UserSession.find_by(uuid: user_session_id)

    if session.nil?
      return {
        error: OpenStruct.new(
          status: 404,
          message: 'Session not found.'
        )
      }
    end

    session.update(vote: vote)
    # TODO: Subscription stuff.
  rescue StandardError => error
    { error: OpenStruct.new(status: 500, message: error.message) }
  end
end
