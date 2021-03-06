class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :active
      t.string :password_hash
      t.string :password_salt

      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
