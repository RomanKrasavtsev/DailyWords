class AddTranscriptionToCards < ActiveRecord::Migration
  def change
    add_column :cards, :transcription, :text
  end
end
