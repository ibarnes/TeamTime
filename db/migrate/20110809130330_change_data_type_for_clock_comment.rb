class ChangeDataTypeForClockComment < ActiveRecord::Migration
  def self.up
   change_column :clocks, :comments, :text
  end

  def self.down
   change_column :clocks, :comments, :text
  end
end
