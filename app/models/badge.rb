class Badge < ApplicationRecord
  belongs_to :user
  belongs_to :achievement
end
