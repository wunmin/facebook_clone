class CreateRounds < ActiveRecord::Migration
  def change
  	create_table :rounds do |round|
  		round.integer :user_id
  		round.integer :deck_id
  		round.timestamps
  	end
  end
end
