class DeleteTranscriptionFromCards < ActiveRecord::Migration
  def change
  	remove_column :cards, :transcription 
  end
end
