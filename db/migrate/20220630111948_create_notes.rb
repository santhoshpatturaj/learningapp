class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :student, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true
      t.string :note_text

      t.timestamps
    end
  end
end
