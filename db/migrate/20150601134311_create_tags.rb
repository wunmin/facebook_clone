class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |tag|
      tag.string :tag_desc
      tag.belongs_to :status
      tag.belongs_to :user
      tag.timestamps
    end
  end
end
