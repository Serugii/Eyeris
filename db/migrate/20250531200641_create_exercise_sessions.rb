class CreateExerciseSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.integer :duration
      t.datetime :performed_at

      t.timestamps
    end
  end
end
