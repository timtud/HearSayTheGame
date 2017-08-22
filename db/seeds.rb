# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
answers_hash = [ {name: 'Kanye West', handle: '@kanyewest', questions: ["I specifically ordered persian rugs with cherub imagery!!! What do I have to do to get a simple persian rug with cherub imagery uuuuuugh", "Yo Britney, I'm really happy for you and I'mma let you be #1, but me and Jay-Z single is one of the best songs of all time! LOL"]},
  { name: 'Conan O’Brien', handle: '@ConanOBrien', questions: ["I just completed 100 push-ups. (I started last November.)", "You call it day drinking, I call it something unintelligible because I’m day drinking."] },
  { name: 'Anna Kendrick', handle: '@AnnaKendrick47', questions: ["I’m so humble it’s crazy. I’m like the Kanye West of humility.", "Hey. People who follow over 1,000 people on twitter. Explain yourselves."] },
  { name: 'Jaden Smith', handle: '@officialjaden', questions: ["Tweets Are Like Tattoos.", "When Life Gives You Big Problems, Just Be Happy You Forgot All Your Little Problems."] },
  { name: 'Donald J. Trump', handle: '@realDonaldTrump', questions: ["I have never seen a thin person drinking Diet Coke.", "My twitter has become so powerful that I can actually make my enemies tell the truth."] },
]

answers_hash.each do |a|
  answer = Answer.new(
    name: a[:name],
    handle: a[:handle]
    )
  answer.save
  a[:questions].each do |q|
    Question.create(
      content: q,
      answer_id: answer.id
      )
  end
end
