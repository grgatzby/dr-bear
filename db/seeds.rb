# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
if Rails.env.development?
  puts "-------------------"
  puts "resetting Database"
  puts "-------------------"
  Answer.destroy_all
  Question.destroy_all
  Category.destroy_all
  Result.destroy_all
  User.destroy_all
end

puts "-------------------"
puts "seeding Users"
puts "-------------------"

User.create!(
  first_name: "Crash",
  last_name: "Dummy",
  email: "crash@dummy.org",
  password: "123456"
)

10.times do |i|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "bear#{i}@user.org",
    password: "123456"
  )
end

puts "-------------------"
puts "seeding Categories"
puts "-------------------"

# input category names and descriptions
categories = [
  { name: "Sleep", description: "Some common types of sleep disorders include:
   Insomnia, in which you have difficulty falling asleep or staying asleep throughout the night.
    Sleep apnea, in which you experience abnormal patterns in breathing while you are asleep. There are several types of sleep apnea. Restless legs syndrome (RLS), a type of sleep movement disorder. Restless legs syndrome, also called Willis-Ekbom disease, causes an uncomfortable sensation and an urge to move the legs while you try to fall asleep. Narcolepsy, a condition characterized by extreme sleepiness during the day and falling asleep suddenly during the day." },

  { name: "Stress", description: "stress symptoms can affect your body, your thoughts and feelings, and your behavior. Being able to recognize common stress symptoms can help you manage them. Stress that's left unchecked can contribute to many health problems, such as high blood pressure, heart disease, obesity and diabetes." }
]

id_cat = []
categories.each do |category|
  seeded_category = Category.create!(
    name: category[:name],
    description: category[:description]
  )
  id_cat.push(seeded_category.id)
end

puts "-------------------"
puts "seeding Questions"
puts "-------------------"

# input questions content for each category
questions = [
  { category_id: id_cat[0], content: "Do you sleep through the night?" },
  { category_id: id_cat[0], content: "Do you have trouble falling asleep?" },
  { category_id: id_cat[0], content: "Do you feel well rested in the morning?" },

  { category_id: id_cat[1], content: "Do you feel stressed on a daily basis?" },
  { category_id: id_cat[1], content: "Do you get agitated easily over things outside your control?" },
  { category_id: id_cat[1], content: "Do you find it difficult to relax?" },
]
# { category_id: id_cat[1], content: "Do you get angry over small things?" }

id_q = []
questions.each do |question|
  seeded_question = Question.create!(
    content: question[:content],
    category_id: question[:category_id]
  )
  id_q.push(seeded_question.id)
  puts "seeded #{seeded_question.content}"
end

puts "-------------------"
puts "seeding Answers"
puts "-------------------"

# input answers content and score for each category/question
answers = [
  { category_id: id_cat[0], question_id: id_q[0], content: "Yes", score: 1 },
  { category_id: id_cat[0], question_id: id_q[0], content: "No", score: 0 },
  { category_id: id_cat[0], question_id: id_q[1], content: "Yes", score: 1 },
  { category_id: id_cat[0], question_id: id_q[1], content: "No", score: 0 },
  { category_id: id_cat[0], question_id: id_q[2], content: "Yes", score: 1 },
  { category_id: id_cat[0], question_id: id_q[2], content: "No", score: 0 },

  { category_id: id_cat[1], question_id: id_q[3], content: "Yes", score: 2 },
  { category_id: id_cat[1], question_id: id_q[3], content: "No", score: 0 },
  { category_id: id_cat[1], question_id: id_q[3], content: "Maybe", score: 1 },
  { category_id: id_cat[1], question_id: id_q[4], content: "Yes", score: 1 },
  { category_id: id_cat[1], question_id: id_q[4], content: "No", score: 0 },
  { category_id: id_cat[1], question_id: id_q[5], content: "Yes", score: 1 },
  { category_id: id_cat[1], question_id: id_q[5], content: "No", score: 0 }
  # { category_id: id_cat[1], question_id: id_q[6], content: "Yes", score: 1 },
  # { category_id: id_cat[1], question_id: id_q[6], content: "No", score: 0 }
]

answers.each do |answer|
  answer = Answer.create!(
    content: answer[:content],
    score: answer[:score],
    question_id: answer[:question_id]
  )
  puts "anser #{answer.id}"
end

puts "-------------------"
puts "seeding Nutrients"
puts "-------------------"

# implement nutrients name and description
nutrients = [
  { name: "Ashwagandha", description: "A stout shrub that produces red berry-like fruit, native to India, Pakistan and Sri Lanka.The herb is also known as Indian ginseng or winter cherry." },
  { name: "Chamomile", description: "(Matricaria recuita) A flowering plant in the daisy (Asteraceae) family. Native to Europe and Western Asia, it's now found around the world. The herb smells slightly like an apple, which may explain its name—chamomile is Greek for Earth apple." },
  { name: "Magnesium oxide", description: "Magnesium oxide is an inorganic salt of magnesium formed with ions of magnesium and oxygen" },
  { name: "Melatonin", description: "A hormone that helps regulate the circadian rhythm (sleep-wake cycle). It is produced by body using tryptophan. Tryptophan is an essential amino acid, meaning the body cannot produce it. Tryptophan is necessary for vital bodily processes, so it must be acquired through plant and animal sources in our diet" },

  { name: "Valerian root", description: "(Valeriana officinalis) An herb from regions of Europe and Asia with medicinal use dating back to ancient Greece and Rome.Valerian root contains valerenic acid, an active ingredient with sedative effects. Specifically, valerenic acid is thought to act on brain receptors for the chemical (neurotransmitter) gamma-aminobutyric acid (GABA). GABA calms and slows the brain." },
  { name: "Vitamin B", description: "The B vitamins, for example, thiamin (B1), riboflavin (B2), niacin (B3), pantothenic acid (B5), pyridoxine (B6), and biotin (B7) work primarily by acting as middlemen in helping our bodies: 1) obtain energy from the food we eat or 2) create new substances in the body." },
  { name: "Inositol", description: "Though often referred to as vitamin B8, inositol is not a vitamin at all but rather a type of sugar with several important functions.It helps provide structure to your cells. It also affects the hormone insulin and the function of chemical messengers in your brain." },
  { name: "Rhodiola rosea", description: "Rhodiola is an herb that grows in the cold, mountainous regions of Europe and Asia. Its roots are considered adaptogens, meaning they help your body adapt to stress when consumed. Rhodiola is also known as arctic root or golden root. Its scientific name is Rhodiola rosea." }
]
id_nutr = []

nutrients.each do |nutrient|
  seeded_nutrient = Nutrient.create!(
    name: nutrient[:name],
    description: nutrient[:description]
  )
  id_nutr.push(seeded_nutrient.id)
end

puts "-------------------"
puts "seeding Category_Nutrients"
puts "-------------------"
# input category_nutrients min_score and max_score
# cat 0 = sleep & cat 1 = stress
# nutri 0 - 4 for sleep ~ cat 0
category_nutrients = [
  { category_id: id_cat[0], nutrient_id: id_nutr[0], min_score: 1, max_score: 3 },
  { category_id: id_cat[0], nutrient_id: id_nutr[1], min_score: 1, max_score: 2 },
  { category_id: id_cat[0], nutrient_id: id_nutr[2], min_score: 1, max_score: 3 },
  { category_id: id_cat[0], nutrient_id: id_nutr[3], min_score: 2, max_score: 3 },

  { category_id: id_cat[1], nutrient_id: id_nutr[4], min_score: 1, max_score: 4 },
  { category_id: id_cat[1], nutrient_id: id_nutr[5], min_score: 2, max_score: 4 },
  { category_id: id_cat[1], nutrient_id: id_nutr[6], min_score: 1, max_score: 3 },
  { category_id: id_cat[1], nutrient_id: id_nutr[7], min_score: 1, max_score: 2 }
]

category_nutrients.each do |category_nutrient|
  CategoryNutrient.create!(
    min_score: category_nutrient[:min_score],
    max_score: category_nutrient[:max_score],
    category_id: category_nutrient[:category_id],
    nutrient_id: category_nutrient[:nutrient_id]
  )
end
