class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :contents, :type, :type_name
  end
end
