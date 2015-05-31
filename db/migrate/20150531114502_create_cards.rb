class CreateCards < ActiveRecord::Migration
  def change
  	create_table :cards do |card|
  		card.string :question
  		card.string :answer
  		card.integer :deck_id
  		card.timestamps
  	end
  end
end
