class CreateGuesses < ActiveRecord::Migration
  def change
  	create_table :guesses do |guess|
  		guess.string :user_answer
  		guess.integer :card_id
  		guess.integer :round_id
  		guess.timestamps
  	end
  end
end
