module Types
  class MutationType < Types::BaseObject
    field :start_planning_room, mutation: Mutations::StartPlanningRoom
    field :establish_user_session, mutation: Mutations::EstablishUserSession
    field :cast_vote, mutation: Mutations::CastVote
    field :rescind_vote, mutation: Mutations::RescindVote
    field :reset_planning_room, mutation: Mutations::ResetPlanningRoom
    field :show_planning_room_results, mutation: Mutations::ShowPlanningRoomResults
    field :rename_planning_room, mutation: Mutations::RenamePlanningRoom
    field :rename_user_session, mutation: Mutations::RenameUserSession
    field :kill_user_session, mutation: Mutations::KillUserSession
  end
end
