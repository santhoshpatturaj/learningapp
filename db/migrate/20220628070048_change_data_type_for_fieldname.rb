class ChangeDataTypeForFieldname < ActiveRecord::Migration[7.0]
  def self.up
    change_table :students do |t|
      t.change :dob, :date
    end
  end
  def self.down
    change_table :students do |t|
      t.change :dob, :datetime
    end
  end
end
