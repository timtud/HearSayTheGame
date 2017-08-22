class Question < ApplicationRecord
  belongs_to :answer
  has_many :round_questions
  validates :content, uniqueness: true, presence: true
end
