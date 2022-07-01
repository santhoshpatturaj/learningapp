class AddTypeToContents < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :type, :integer, default: 0
  end
end
