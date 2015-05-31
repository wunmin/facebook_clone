class CreateDecks < ActiveRecord::Migration
  def change
  	create_table :decks do |deck|
  		deck.string :name
  		deck.timestamps
  	end
  end
end
