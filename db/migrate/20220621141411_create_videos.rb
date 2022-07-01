class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :thumbnail
      t.time :duration
      t.string :link

      t.timestamps
    end
  end
end
