class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :score
      t.boolean :pass
      t.references :student, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
