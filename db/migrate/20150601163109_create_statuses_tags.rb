class CreateStatusesTags < ActiveRecord::Migration
  def change
  	create_table :statuses_tags do |statuses_tag|
      statuses_tag.belongs_to :status
      statuses_tag.belongs_to :user
      statuses_tag.timestamps
    end
  end
end
