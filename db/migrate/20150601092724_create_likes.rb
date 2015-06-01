class CreateLikes < ActiveRecord::Migration
  def change
  	create_table :likes do |like|
  		like.belongs_to :user
  		like.belongs_to :status
  		like.timestamps
  	end
  end
end
