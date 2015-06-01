class Profile < ActiveRecord::Base
  belongs_to :user

  validates :name, :email, :dob, presence: true
end