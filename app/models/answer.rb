class Answer < ApplicationRecord
  has_many :questions
  validates :name, uniqueness: true, presence: true
  validates :handle, uniqueness: true, presence: true
end
