module BadgeCreator
  def check_achievements(type)
    send((type + '_achievements').to_sym)
  end

  def create_badge(type, name)
    return if achievement_already_reached?(type)
    id = Achievement.find_by_identity(type).id
    current_user.badges.create(achievement_id: id)
    flash[:achievement] = name 
  end

  def achievement_already_reached?(type)
    current_user.achievements.exists?(identity: type) 
  end

  #This is where you create the custom achievement logic - each method corresponds to a controller
  #to do: relocate this section - to their own files/module?
  
  def task_achievements()
    #condition(s)
    # task_count = current_user.tasks.count_completed(current_user)
    rounds_count = current_user.rounds.count
    round_correct = @round.correct_count
    player_score_count = current_user.player_score
    following_count = @user.following.count

    #achievements
    #Playing for the first time (TO DO - Add to the rounds controller)
    create_badge('Nicholas Birdcage', 'Put... the parrot... back... in the box.')  if rounds_count == 1

    #Play 3 days in a row (TO DO)

    #0/10 in a round
    create_badge('Donald Jay Trump', 'Your answers are fake news.')  if round_correct == 0

    #10/10 in a round
    create_badge('Swanye West', 'That was one of the best rounds of all time. ALL TIME!')  if round_correct == 10

    #Breaking 2000 fame points
    create_badge('Hennifer Lopez', 'I\'m still Henny from the flock.')  if player_score_count >= 2000

    #Breaking 5000 fame points
    create_badge('Parrots Hilton', 'That\'s hot.')  if player_score_count >= 5000

    #Breaking 10000 fame points
    create_badge('Kim Kardadasha-too', 'Wow, you just broke the Internet!')  if player_score_count >= 10000

    #Follow 5 users
    create_badge('Stephen Sqwuaking', 'We are all now connected by the Internet, like neurons in a giant brain.')  if following_count >= 5

    #Be unfollowed by another user (TO DO)
    #Completing profile (TO DO)
    #Share your score on Facebook or Twitter (TO DO)
  end
end