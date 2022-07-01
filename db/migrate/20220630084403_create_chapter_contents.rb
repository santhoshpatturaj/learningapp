class CreateChapterContents < ActiveRecord::Migration[7.0]
  def change
    create_table :chapter_contents do |t|
      t.references :chapter, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
