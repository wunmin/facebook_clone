class Card < ActiveRecord::Base
  belongs_to :deck
  has_one :guess

  def self.sample_card(round)
  	@round = Round.find(round)
  	@card = @round.cards.sample
  	
  	played_cards_ids = []
  	# An array of all cards played in that round
  	@round.guesses.each do |guess|
  		played_cards_ids << guess.card_id
  	end

  	until !played_cards_ids.include?(@card.id)
  		@card = @round.cards.sample
  	end
  	@card
  end
end
