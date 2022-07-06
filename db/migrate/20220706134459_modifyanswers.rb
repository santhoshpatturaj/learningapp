class Modifyanswers < ActiveRecord::Migration[7.0]
  def change
    change_column :answers, :option, 'integer USING CAST(option AS integer)'
  end
end
