enable :sessions

get '/' do
	if !session[:id].nil?
		@decks = Deck.all
		erb :decks
	else
  		erb :index
  	end
end

# User authentication
post "/login" do
	# @auth_result = nil or @user
	@auth_result = User.authenticate(params[:user][:username], params[:user][:password])
	if @auth_result == nil
		redirect to("/")
	else
		session[:id] = @auth_result.id
		redirect to("/decks")
	end
end

# List all the decks
get "/decks" do
	@decks = Deck.all
	erb :decks
	p session[:id]
end

# First card
get "/decks/:deck_id/" do
	@deck = Deck.find(params[:deck_id])
	@card = @deck.cards.sample

	@count = 0
	# @deck = Deck.find(params[:deck_id])
	# @shuffled_cards = @deck.cards.shuffle
	# @card = @shuffled_cards[@count]
	session[:id]
	@round = Round.create(user_id: session[:id], deck_id: @deck.id)
	byebug
	erb :card_1
end

# Update the Guess table, and redirect to next card
post "/rounds/:round_id/decks/:deck_id/questions/:question_id" do
	byebug
	@guess = Guess.create(user_answer: params[:user_answer], card_id: params[:old_card_id], round_id: params[:round_id].to_i)
	session[:id]
	redirect to "/rounds/#{params[:round_id]}/decks/#{params[:deck_id]}/questions/#{params[:question_id].to_i + 1}"
end

# Second cards onwards, can show card_id
get "/rounds/:round_id/decks/:deck_id/questions/:question_id" do
	session[:id]
	@old_card_id = Guess.last.card_id
	@old_card = Card.find(@old_card_id)

	@old_guess = Guess.where(card_id: @old_card_id, round_id: params[:round_id].to_i)
	@deck = Deck.find(params[:deck_id])
	if params[:question_id].to_i > @deck.cards.count
		redirect to "/results"
	else
		@round = params[:round_id]
		# @user = @round.user
		@deck = params[:deck_id]
		@new_card = Card.sample_card(@round)
		@question_id = params[:question_id].to_i
		erb :card
	end
end


# List the results of all rounds played
get "/results" do
	@user = session[:id]
	@rounds = @user.rounds

	@num_correct_by_rounds = []
	@rounds.each do |round|
		@num_correct = 0
		@all_guesses = Guess.where(round_id: params[:round_id])

		@all_guesses.each do |guess|
			card_answer = Card.find(guess.card_id).answer
			if guess.user_answer == card_answer
				@num_correct += 1
			end
		end
	 @num_correct_by_rounds	<< @num_correct
	end

	erb :results
end

