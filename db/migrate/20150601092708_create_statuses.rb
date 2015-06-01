class CreateStatuses < ActiveRecord::Migration
  def change
  	create_table :statuses do |status|
  		status.text :status_desc
  		status.belongs_to :user
  		status.timestamps
  	end
  end
end
