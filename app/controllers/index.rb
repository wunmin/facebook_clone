enable :sessions

get '/' do
	if !session[:id].nil?
		@user = User.find(session[:id])
		if !@user.profile.nil?
			redirect to "/users/#{@user.id}/statuses"
		else
			redirect to "/users/#{@user.id}/new"
		end
	else
		User.create
  		erb :index
  	end
end

# User authentication
post "/login" do
	# @user will be nill or an User object
	@user = User.authenticate(params[:user][:username], params[:user][:password])
	if @user == nil
		redirect to("/")
	else
		session[:id] = @user.id
		redirect to("/users/#{@user.id}/statuses")
	end
end

# Create a new user
post "/new_user" do
	# @auth_result = nil or @user
	@new_user = User.create(params[:new_user])
	@new_profile = Profile.create(
		name: params[:profile][:name],
		email: params[:profile][:email],
		dob: params[:profile][:dob],
		user_id: @new_user.id
		)

	if @new_user == nil
		erb :index
	else
		session[:id] = @new_user.id
		redirect to("/users/#{@new_user.id}/statuses")
	end
end

# List all statuses for the logged in user
get "/users/:user_id/statuses" do
	@user = User.find(params[:user_id])
	@statuses = Status.all
	erb :statuses
end

# Add like for one particular user
post "/users/:user_id/statuses/:status_id/like" do
	@user = User.find(params[:user_id])
	@status = Status.find(params[:status_id])
	if Like.find_by(user_id: @user.id, status_id: @status.id).nil?
		@new_like = Like.create(user_id: @user.id, status_id: @status.id)
	end
	redirect to("/users/#{params[:user_id]}/statuses/#{params[:status_id]}")
end

# Add a status for one particular user
post "/users/:user_id/statuses/add" do
	@user = User.find(params[:user_id])
	@new_status = @user.statuses.create(params[:user])
	tags_array = params[:tags].split(", ")
	tags_array.each do |tag|
        Tag.create(
        	tag_desc: tag,
        	user_id: @user.id,
        	status_id: @new_status.id
        	)
 	end
	redirect to("/users/#{@user.id}/statuses")
end

# Get page for one particular status
get "/users/:user_id/statuses/:status_id" do
	@status = Status.find(params[:status_id])
	@tags = Tag.where(status_id: params[:status_id], user_id: params[:user_id])
	@user = User.find(params[:user_id])
	erb :status
end

# Delete one particular status
delete '/users/:user_id/statuses/:status_id/delete' do
	@status = Status.find(params[:status_id])
	@status.destroy
    redirect to "/users/#{params[:user_id]}/statuses"
end

# Display page to edit one particular status
get '/users/:user_id/statuses/:status_id/edit' do
	@status = Status.find(params[:status_id])
	erb :status_edit
  	# redirect to "/users/#{params[:user_id]}/statuses/#{params[:status_id]}"
end

# Edit one particular status
put '/users/:user_id/statuses/:status_id/edit' do
  @status = Status.find(params[:status_id])
  @status.update(params[:user])
  redirect to "/users/#{params[:user_id]}/statuses/#{params[:status_id]}"
end

# Delete a comment for one particular status
delete '/users/:user_id/statuses/:status_id/comments/:comment_id/delete' do
	@comment = Comment.find(params[:comment_id])
	@comment.destroy
    redirect to "/users/#{params[:user_id]}/statuses/#{params[:status_id]}"
end

# Add a comment for one particular status
post "/users/:user_id/statuses/:status_id/comments/add" do
	# @user = User.find(params[:user_id]) 
	@status = Status.find(params[:status_id])
	@new_comment = @status.comments.create(params[:user])
	redirect to("/users/#{params[:user_id]}/statuses/#{params[:status_id]}")
end

# Display page to edit one particular comment
get '/users/:user_id/statuses/:status_id/comments/:comment_id/edit' do
	@comment = Comment.find(params[:comment_id])
	erb :comment_edit
  	# redirect to "/users/#{params[:user_id]}/statuses/#{params[:status_id]}"
end

# Edit one particular comment for a status
put '/users/:user_id/statuses/:status_id/comments/:comment_id/edit' do
  @comment = Comment.find(params[:comment_id])
  @comment.update(params[:user])
  redirect to "/users/#{params[:user_id]}/statuses/#{params[:status_id]}"
end

# Logout and clear session
get "/logout" do
	session.clear
	redirect to "/"
end

# Display user profile
get "/users/:user_id/profile" do
	@user = User.find(params[:user_id])
	erb :profile
end

# Display page to edit user profile
get "/users/:user_id/edit" do
	@profile = Profile.find_by_user_id(params[:user_id])
	erb :profile_edit
end

# Edit one particular user's profile
put '/users/:user_id/edit' do
	@profile = Profile.find_by_user_id(params[:user_id])
	@profile.update(
		name: params[:profile][:name],
		email: params[:profile][:email],
		dob: params[:profile][:dob],
		user_id: params[:user_id]
		)
	redirect to "/users/#{params[:user_id]}/profile"
end

# Delete user profile
delete '/users/:user_id/delete' do
	@profile = Profile.find_by_user_id(params[:user_id])
	@profile.destroy
    erb :profile_new
end

# Create one particular user's new profile
post '/users/:user_id/new' do
	@new_profile = Profile.create(
		name: params[:profile][:name],
		email: params[:profile][:email],
		dob: params[:profile][:dob],
		user_id: params[:user_id]
		)
	redirect to "/users/#{params[:user_id]}/profile"
end

# Display opage to create new profile
get '/users/:user_id/new' do
	erb :profile_new
end

# Display a page with all the user's statuses that match the tag
get '/users/:user_id/tags/:tag_id' do
	@tag_desc = Tag.find(params[:tag_id]).tag_desc
	@tag_objects = Tag.where(tag_desc: @tag_desc, user_id: params[:user_id])
	@statuses = []
	@tag_objects.each do |tag_object|
		new_status = Status.find(tag_object.status_id)
		@statuses << new_status
	end
	erb :tag_statuses
end













