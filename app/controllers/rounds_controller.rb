class RoundsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @round = Round.find(params[:id])
    # maybe display final results
    if @round.round_questions.where(answered: false).first
      answer = @round.round_questions.where(answered: false).first.question.answer
      @answers = Answer.where.not(name: answer.name).order("RANDOM()")[0..2]
      @answers << answer
      @answers.shuffle!
    else
      redirect_to root_path
    end
  end

  def update
    @round = Round.find(params[:id])
    answer = @round.round_questions.where(answered: false).first
    answer.update(answered: true)
    if answer.save
      redirect_to @round
    else
      redirect_to root_path
    end
  end

  def create
    #Creates 10 random questions
    questions = Question.order("RANDOM()")[0..9]
    @round = Round.create(user_id: current_user.id, score: 0, correct_count: 0)
    questions.each do |q|
      @round.round_questions.create(question: q, answered: false)
    end
    if @round.save
      redirect_to @round
    else
      redirect_to root_path
    end
  end
end
