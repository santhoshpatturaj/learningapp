class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.integer :no_of_questions
      t.integer :marks
      t.time :duration

      t.timestamps
    end
  end
end
