class RoundsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @round = Round.find(params[:id])
  end

  def update
  end

  def create
    questions = [ #10 random questions here ]
    @round = Round.build
    # each loop questions |q|
    # @round.round_questions.create(q)
  end
end
