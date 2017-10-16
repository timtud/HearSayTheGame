module BadgeCreator
  def check_achievements(type)
    send((type + '_achievements').to_sym)
  end

  def create_badge(type, name)
    return if achievement_already_reached?(type)
    id = Achievement.find_by_identity(type).id
    current_user.badges.create(achievement_id: id)
    # flash[:achievement] = name
    flash[:achievement] = identity
  end

  def achievement_already_reached?(type)
    current_user.achievements.exists?(identity: type) 
  end

  #This is where you create the custom achievement logic - each method corresponds to a controller
  #to do: relocate this section - to their own files/module?
  
  def round_achievements()
    #CONDITION(S)
    rounds_count = current_user.rounds.count
    round_correct = @round.correct_count
    player_score_count = current_user.player_score
    following_count = @user.following.count

    #ACHIEVEMENTS [identity (acts as ID), name, description, image_url]
    #Playing for the first time
    create_badge('Playing for the first time', 'Nicholas Birdcage', 'Put... the parrot... back... in the box.', 'cloudinary url')  if rounds_count == 1

    #Play 3 days in a row (TO DO)

    #0/10 in a round
    create_badge('0/10 in a round', 'Donald Jay Trump', 'Your answers are fake news.', 'cloudinary url')  if round_correct == 0

    #10/10 in a round
    create_badge('10/10 in a round', 'Swanye West', 'That was one of the best rounds of all time. ALL TIME!', 'cloudinary url')  if round_correct == 10

    #Breaking 2000 fame points
    create_badge('2000 fame points', 'Hennifer Lopez', 'I\'m still Henny from the flock.', 'cloudinary url')  if player_score_count >= 2000

    #Breaking 5000 fame points
    create_badge('5000 fame points', 'Parrots Hilton', 'That\'s hot.', 'cloudinary url')  if player_score_count >= 5000

    #Breaking 10000 fame points
    create_badge('10000 fame points', 'Kim Kardadasha-too', 'Wow, you just broke the Internet!', 'cloudinary url')  if player_score_count >= 10000


    #Completing profile (TO DO)
    #Share your score on Facebook or Twitter (TO DO)
  end

  def relationship_achievements()
  	#Follow 5 users
    create_badge('Follow 5 users', 'Stephen Sqwuaking', 'We are all now connected by the Internet, like neurons in a giant brain.', 'cloudinary url')  if following_count >= 5

    #Be unfollowed by another user (TO DO)
  end

  def controllername_achievements()
  	#TO DO: INSERT BADGES CORRESPONDING TO THIS CONTROLLER. THEN JUST CALL THIS METHOD ON CONTROLLERNAME UPDATE
  end
end