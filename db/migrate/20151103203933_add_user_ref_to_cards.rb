class AddUserRefToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :user, index: true, foreign_key: true
  end
end
