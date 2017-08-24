class Round < ApplicationRecord
  belongs_to :user , optional: true
  has_many :round_questions # Try to validate 10 questions
end
