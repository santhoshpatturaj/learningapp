class CreateStudentCompletes < ActiveRecord::Migration[7.0]
  def change
    create_table :student_completes do |t|
      t.references :student, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
