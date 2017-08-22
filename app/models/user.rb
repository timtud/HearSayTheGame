class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :followers
  has_many :rounds


  def total_score
    total = 0;
    self.rounds.each do |round|
      total += round.score
    end
    total
  end

  def self.cal_score(array)
    total = 0;
    array.each do |round|
      total += round.score
    end
    total
  end

  def self.top_players(hash = "")
    board = User.all.map do |user|
      if hash == 'day'
        user_score = User.cal_score(user.rounds.where("created_at >= ?", Time.zone.now.beginning_of_day))
      elsif hash == 'week'
        user_score = User.cal_score(user.rounds.where("created_at >= ?", Time.zone.now.beginning_of_week))
      elsif hash == "month"
        user_score = User.cal_score(user.rounds.where("created_at >= ?", Time.zone.now.beginning_of_month))
      else
        user_score = user.total_score
      end
      [user_score, user.email]
    end
    board.sort! do |a,b|
      b[0] <=> a[0]
    end
  end
end
