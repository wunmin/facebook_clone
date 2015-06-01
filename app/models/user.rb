class User < ActiveRecord::Base
  has_one :profile
  has_many :statuses
  has_many :comments
  has_many :likes
  has_and_belongs_to_many :tags
  validates :username, :password, presence: true

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
