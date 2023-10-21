module Types
  class MutationType < Types::BaseObject
    field :start_planning_room, mutation: Mutations::StartPlanningRoom
    field :establish_user_session, mutation: Mutations::EstablishUserSession
  end
end
