# A user's session; we've really got no concept of "user" other
# than this. Most importantly it represents the cookie (UUID) that
# identifies a particular person's session, and their currently casted vote.
class UserSession < ApplicationRecord
  include ModelHelpers::Uuid

  belongs_to :planning_room
end
