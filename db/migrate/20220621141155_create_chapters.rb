class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :chapter_name
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
