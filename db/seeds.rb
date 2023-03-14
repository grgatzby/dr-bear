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

  { name: "Stress", description: "Stress symptoms can affect your body, your thoughts and feelings, and your behavior. Being able to recognize common stress symptoms can help you manage them. Stress that's left unchecked can contribute to many health problems, such as high blood pressure, heart disease, obesity and diabetes." },
  { name: "Energy", description: "Something about Energy" },
  { name: "Heart", description: "Heart disease description" },
  { name: "Cholosterol", description: "Cholestrol issues" }

]

id_cat = []
categories.each do |category|
  seeded_category = Category.create!(
    name: category[:name],
    description: category[:description]
  )
  id_cat.push(seeded_category.id)
  puts "seeded #{seeded_category.name}"
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

  { category_id: id_cat[2], content: "Energy Q1?" },
  { category_id: id_cat[2], content: "Energy Q2?" },
  { category_id: id_cat[2], content: "Energy Q3?" },

  { category_id: id_cat[3], content: "heart Q1?" },
  { category_id: id_cat[3], content: "Heart Q2?" },
  { category_id: id_cat[3], content: "Heart Q3?" },

  { category_id: id_cat[4], content: "Cholosterol Q1 ?" },
  { category_id: id_cat[4], content: "Cholosterol Q2 ?" },
  { category_id: id_cat[4], content: "Cholosterol Q3 ?" },

]

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
  { category_id: id_cat[1], question_id: id_q[5], content: "No", score: 0 },

  { category_id: id_cat[2], question_id: id_q[6], content: "Yes", score: 1 },
  { category_id: id_cat[2], question_id: id_q[6], content: "No", score: 0 },
  { category_id: id_cat[2], question_id: id_q[7], content: "Yes", score: 1 },
  { category_id: id_cat[2], question_id: id_q[7], content: "No", score: 0 },
  { category_id: id_cat[2], question_id: id_q[8], content: "Yes", score: 1 },
  { category_id: id_cat[2], question_id: id_q[8], content: "No", score: 0 },

  { category_id: id_cat[3], question_id: id_q[9], content: "Yes", score: 1 },
  { category_id: id_cat[3], question_id: id_q[9], content: "No", score: 0 },
  { category_id: id_cat[3], question_id: id_q[10], content: "Yes", score: 1 },
  { category_id: id_cat[3], question_id: id_q[10], content: "No", score: 0 },
  { category_id: id_cat[3], question_id: id_q[11], content: "Yes", score: 1 },
  { category_id: id_cat[3], question_id: id_q[11], content: "No", score: 0 },

  { category_id: id_cat[4], question_id: id_q[12], content: "Yes", score: 1 },
  { category_id: id_cat[4], question_id: id_q[12], content: "No", score: 0 },
  { category_id: id_cat[4], question_id: id_q[13], content: "Yes", score: 1 },
  { category_id: id_cat[4], question_id: id_q[13], content: "No", score: 0 },
  { category_id: id_cat[4], question_id: id_q[14], content: "Yes", score: 1 },
  { category_id: id_cat[4], question_id: id_q[14], content: "No", score: 0 }

]

answers.each do |answer|
  answer = Answer.create!(
    content: answer[:content],
    score: answer[:score],
    question_id: answer[:question_id]
  )
  puts "answer #{answer.id}, #{answer.content}"
end

puts "-------------------"
puts "seeding Nutrients"
puts "-------------------"

# implement nutrients name and description
nutrients = [
  { name: "Vitamin A",
    description: "Vitamin A description",
    nutri_code: "320" },

  { name: "Vitamin B1 (Thiamin)",
    description: "Vitamin B1 description",
    nutri_code: "404" },

  { name: "Vitamin B2 (Riboflavin)",
    description: "Vitamin B2 description",
    nutri_code: "405" },

  { name: "Vitamin B3 (Niacin)",
    description: "Vitamin B3 description",
    nutri_code: "406" },

  { name: "Vitamin B6",
    description: "Vitamin B6 description",
    nutri_code: "415" },

  { name: "Vitamin B12",
    description: "Vitamin B12 description",
    nutri_code: "418" },

  { name: "Vitamin C",
    description: "Vitamin C description",
    nutri_code: "401" },

  { name: "Calcium",
    description: "Calcium description",
    nutri_code: "301" },

  { name: "Vitamin D",
    description: "Vitamin D description",
    nutri_code: "328" },

  { name: "Vitamin E",
    description: "Vitamin E description",
    nutri_code: "323" },

  { name: "Folate",
    description: "Folate description",
    nutri_code: "417" },

  { name: "Vitamin K",
    description: "vitamin K description",
    nutri_code: "430" },

  { name: "Magnesium",
    description: "Magnesium description",
    nutri_code: "304" },

  { name: "Potassium",
    description: "Potassium description",
    nutri_code: "306" },

  { name: "Sodium",
    description: "Sodium description",
    nutri_code: "307" }
]
id_nutr = []

nutrients.each do |nutrient|
  seeded_nutrient = Nutrient.create!(
    name: nutrient[:name],
    description: nutrient[:description],
    nutri_code: nutrient[:nutri_code]
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
  { category_id: id_cat[0], nutrient_id: id_nutr[1], min_score: 2, max_score: 3 },
  { category_id: id_cat[0], nutrient_id: id_nutr[2], min_score: 3, max_score: 3 },

  { category_id: id_cat[1], nutrient_id: id_nutr[3], min_score: 1, max_score: 5 },
  { category_id: id_cat[1], nutrient_id: id_nutr[4], min_score: 3, max_score: 5 },
  { category_id: id_cat[1], nutrient_id: id_nutr[5], min_score: 5, max_score: 5 },

  { category_id: id_cat[2], nutrient_id: id_nutr[6], min_score: 1, max_score: 3 },
  { category_id: id_cat[2], nutrient_id: id_nutr[7], min_score: 2, max_score: 3 },
  { category_id: id_cat[2], nutrient_id: id_nutr[8], min_score: 3, max_score: 3 },

  { category_id: id_cat[3], nutrient_id: id_nutr[9], min_score: 1, max_score: 3 },
  { category_id: id_cat[3], nutrient_id: id_nutr[10], min_score: 2, max_score: 3 },
  { category_id: id_cat[3], nutrient_id: id_nutr[11], min_score: 3, max_score: 3 },

  { category_id: id_cat[4], nutrient_id: id_nutr[12], min_score: 1, max_score: 3 },
  { category_id: id_cat[4], nutrient_id: id_nutr[13], min_score: 2, max_score: 3 },
  { category_id: id_cat[4], nutrient_id: id_nutr[14], min_score: 3, max_score: 3 }
]

category_nutrients.each do |category_nutrient|
  CategoryNutrient.create!(
    min_score: category_nutrient[:min_score],
    max_score: category_nutrient[:max_score],
    category_id: category_nutrient[:category_id],
    nutrient_id: category_nutrient[:nutrient_id]
  )
end
