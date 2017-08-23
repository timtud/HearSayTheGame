class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

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

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

#  ----> Added method for Twitter authentication
  def self.find_for_twitter_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:nickname, :first_name, :last_name)
    user_params[:picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    # user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.email = "#{user.nickname}@twitter.com"
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user

  end
end
