class Achievement < ApplicationRecord
  has_many :badges
  has_many :users, through: :badges
end
