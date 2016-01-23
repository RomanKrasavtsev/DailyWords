class AddTelegramIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :telegram_id, :integer
  end
end
