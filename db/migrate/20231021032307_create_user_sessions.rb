class CreateUserSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sessions do |t|
      t.string :uuid
      t.string :name
      t.string :vote
      t.references :planning_room, index: true

      t.timestamps
    end
  end
end
