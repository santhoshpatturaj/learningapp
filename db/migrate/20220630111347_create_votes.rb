class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :student, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true
      t.boolean :upvote
      t.boolean :downvote

      t.timestamps
    end
  end
end
