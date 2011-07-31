class CreateClocks < ActiveRecord::Migration
  def self.up
    create_table :clocks do |t|
      t.integer :in_out
      t.integer :user_id
      t.string  :comments
      t.integer :task_id

      t.timestamps
    end
  end

  def self.down
    drop_table :clocks
  end
end
