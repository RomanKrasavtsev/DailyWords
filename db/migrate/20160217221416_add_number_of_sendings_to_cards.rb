class AddNumberOfSendingsToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :number_of_sendings, :integer, default: 0
  end
end
