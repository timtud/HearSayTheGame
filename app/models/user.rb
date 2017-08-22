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

  def self.top_players
    board = User.all.map do |user|
      [user.total_score, user.email]
    end
    board.sort! do |a,b|
      b[0] <=> a[0]
    end
  end

  def self.top_players_day
    board = User.all(:conditions => { :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight}).map do |user|
      [user.total_score, user.email]
    end
    board.sort! do |a,b|
      b[0] <=> a[0]
    end
    board[0..10]
  end

end
