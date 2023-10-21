class CreatePlanningRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :planning_rooms do |t|
      t.string :uuid
      t.string :name
      t.boolean :showing_results, default: false, null: false

      t.timestamps
    end
  end
end
