class CreateProfiles < ActiveRecord::Migration
  def change
  	create_table :profiles do |profile|
  		profile.string :name
  		profile.string :email
  		profile.date :dob
  		profile.belongs_to :user
  		profile.timestamps
  	end
  end
end
