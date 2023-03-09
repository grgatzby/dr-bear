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
  { name: "Sleep", description: Faker::Lorem.paragraph },
  { name: "Stress", description: Faker::Lorem.paragraph }
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

  { category_id: id_cat[1], content: "Do you feel stressed?" },
  { category_id: id_cat[1], content: "Do you get angry easily?" },
  { category_id: id_cat[1], content: "Question stress 3?" },
  { category_id: id_cat[1], content: "Question stress 4?" }
]

id_q = []
questions.each do |question|
  seeded_question = Question.create!(
    content: question[:content],
    category_id: question[:category_id]
  )
  id_q.push(seeded_question.id)
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
  { category_id: id_cat[1], question_id: id_q[6], content: "Yes", score: 1 },
  { category_id: id_cat[1], question_id: id_q[6], content: "No", score: 0 }
]

answers.each do |answer|
  Answer.create!(
    content: answer[:content],
    score: answer[:score],
    question_id: answer[:question_id]
  )
end

puts "-------------------"
puts "seeding Nutrients"
puts "-------------------"

# implement nutrients name and description
nutrients = [
  { name: "Iron", description: Faker::Lorem.paragraph },
  { name: "Magnesium", description: Faker::Lorem.paragraph },
  { name: "Melatonin", description: Faker::Lorem.paragraph },
  { name: "Omega-3", description: Faker::Lorem.paragraph },
  { name: "Vitamin D", description: Faker::Lorem.paragraph }

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
category_nutrients = [
  { category_id: id_cat[0], nutrient_id: id_nutr[0], min_score: 1, max_score: 2 },
  { category_id: id_cat[0], nutrient_id: id_nutr[1], min_score: 2, max_score: 2 },
  { category_id: id_cat[0], nutrient_id: id_nutr[2], min_score: 2, max_score: 2 },
  { category_id: id_cat[0], nutrient_id: id_nutr[3], min_score: 2, max_score: 2 },
  { category_id: id_cat[0], nutrient_id: id_nutr[4], min_score: 2, max_score: 2 },

  { category_id: id_cat[1], nutrient_id: id_nutr[0], min_score: 1, max_score: 1 },
  { category_id: id_cat[1], nutrient_id: id_nutr[1], min_score: 1, max_score: 3 },
  { category_id: id_cat[1], nutrient_id: id_nutr[2], min_score: 1, max_score: 3 },
  { category_id: id_cat[1], nutrient_id: id_nutr[3], min_score: 1, max_score: 3 },
  { category_id: id_cat[1], nutrient_id: id_nutr[4], min_score: 0, max_score: 3 }
]

category_nutrients.each do |category_nutrient|
  CategoryNutrient.create!(
    min_score: category_nutrient[:min_score],
    max_score: category_nutrient[:max_score],
    category_id: category_nutrient[:category_id],
    nutrient_id: category_nutrient[:nutrient_id]
  )
end
