class Round < ActiveRecord::Base
  belongs_to :user
  has_many :guesses
  belongs_to :deck
  has_many :cards, through: :deck
end