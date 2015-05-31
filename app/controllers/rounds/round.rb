# User authentication
post "/login" do
	# @auth_result = nil or @user
	byebug
	@auth_result = User.authenticate(params[:user])
	if @auth_result == nil
		redirect to("/")
	else
		session[:user_id] = @auth_result.id
		redirect to("/decks")
	end
end

# List all the decks
get "/decks" do
	@decks = Deck.all
end

# 
get "/decks/:deck_id" do
	
end

# List one card for one particular deck
get "/rounds/:round_id/decks/:deck_id/cards/:card_id" do
end

# Update the Guess table
post "/rounds/:round_id/decks/:deck_id/cards/:card_id" do
end

# List the results of all rounds played
get "/results" do
end



