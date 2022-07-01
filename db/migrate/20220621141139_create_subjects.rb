class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :subject_name
      t.references :board, foreign_key: true
      t.references :grade, foreign_key: true

      t.timestamps
    end
  end
end
