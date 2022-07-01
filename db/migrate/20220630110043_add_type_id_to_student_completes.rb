class AddTypeIdToStudentCompletes < ActiveRecord::Migration[7.0]
  def change
    add_column :student_completes, :type_id, :integer
  end
end
