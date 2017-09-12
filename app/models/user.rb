class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # include PgSearch
  # pg_search_scope :search_by_first_name_and_last_name_, against: [ :title, :syllabus ]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :followers
  has_many :rounds

  # pg_search_scope :search_by_first_name_and_last_name_, against: [ :title, :syllabus ]
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  has_attachment :photo

  validates_length_of :bio, :maximum => 140, :allow_blank => true
  validates_length_of :first_name, :maximum => 40
  validates_length_of :last_name, :maximum => 40
  validates_length_of :handle, :maximum => 15, :allow_blank => true
  validates :handle, uniqueness: true, :allow_blank => true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :twitter, :with => /http(?:s)?:\/\/(?:www.)?twitter\.com\/([a-zA-Z0-9_]+)/, :allow_blank => true


  def get_username
    unless self.handle.nil?
      return self.handle
    else
      return "#{self.first_name}#{self.last_name}".gsub(/\s+/, "")
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def country_name
    country = ISO3166::Country[location]
  end

  def total_score
    total = 0;
    self.rounds.each do |round|
      total += round.score
    end
    total
  end

  def player_score(hash = "")
    if hash == 'day'
        user_score = User.cal_score(self.rounds.where("created_at >= ?", Time.zone.now.beginning_of_day))
      elsif hash == 'week'
        user_score = User.cal_score(self.rounds.where("created_at >= ?", Time.zone.now.beginning_of_week))
      elsif hash == "month"
        user_score = User.cal_score(self.rounds.where("created_at >= ?", Time.zone.now.beginning_of_month))
      else
        user_score = self.total_score
    end
    user_score
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

  def self.top_round
    board = User.all.map do |user|
      if user.rounds.maximum(:score)
        user_score = user.rounds.maximum(:score)
      else
        user_score = 0
      end
      [user_score, user.email]
    end
    board.sort! do |a,b|
      b[0] <=> a[0]
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
    user_params.merge! auth.info.slice(:nickname)
    user_params[:picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    # user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    name = auth.info.name
    first = name.split(" ").first
    name = name.split(" ")
    name.delete_at(0)
    last = name.join(" ")

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.handle = user_params["nickname"]
      user.first_name = first
      user.last_name = last
      user.email = "#{user.nickname}@twitter.com"
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user

  end
end
