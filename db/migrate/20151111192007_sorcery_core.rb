class SorceryCore < ActiveRecord::Migration
  def change
    add_column :users, :salt, :string
    rename_column :users, :password, :crypted_password
    change_column_null :users, :email, false
    add_index :users, :email, unique: true
  end
end
