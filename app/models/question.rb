class Question < ApplicationRecord
  belongs_to :answer
  has_many :round_questions
end
