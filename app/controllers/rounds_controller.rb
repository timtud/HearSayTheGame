class RoundsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @round = Round.find(params[:id])
    # maybe display final results
  end

  def update
  end

  def create
    #Creates 10 random questions
    questions = []
    10.times do
      new_question = Question.order("RANDOM()").first
      until questions.exclude? new_question
        new_question = Question.order("RANDOM()").first
      end
      questions << new_question
    end
    @round = Round.build
    questions.each do |q|
      @round.round_questions.create(q)
    end
    if @round.save
      redirect_to @round.round_questions.first
    else
      redirect_to root_path
    end
  end
end
