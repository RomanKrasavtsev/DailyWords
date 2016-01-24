class AddTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_from, :time
    add_column :users, :time_to, :time
  end
end
