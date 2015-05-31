class User < ActiveRecord::Base
  has_many :rounds
  has_many :guesses, through: :round

  def self.authenticate(username, password)
    @user = User.find_by_username(username)
    if @user == []
      nil
    elsif @user.password == password
      @user
    else
      nil
    end
  end

end
