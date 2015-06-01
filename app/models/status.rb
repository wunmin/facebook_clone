class Status < ActiveRecord::Base
  	belongs_to :user
  	has_many :comments
  	has_many :likes
  	has_many :tags
  	has_and_belongs_to_many :tags
end
