class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :full_name
      t.string :mobile
      t.string :email, null: false
      t.datetime :dob
      t.string :otp
      t.timestamp :otp_timestamp
      t.string :profile_photo
      t.references :board, foreign_key: true
      t.references :grade, foreign_key: true
      
      t.timestamps
    end
  end
end
