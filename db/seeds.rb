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
dummy_user = User.create(
  first_name: "Crash",
  last_name: "Dummy",
  email: "crash@dummy.com",
  password: "123456"
)

10.times do |i|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "drbear#{i}@gmail.com",
    password: "123456"
  )
end

puts "-------------------"
puts "seeding Categories"
puts "-------------------"

categories = [
  { name: "Sleep", description: Faker::Lorem.paragraph },
  { name: "Stress", description: Faker::Lorem.paragraph }
]
raise

categories.each do |category|
  seeded_category = Category.create!(
    name: category[:name],
    description: category[:description]
  )

end

puts "-------------------"
puts "seeding Questions"
puts "-------------------"

questions = [
  { category_id: 1, content: "Do you sleep through the night?" },
  { category_id: 1, content: "Do you have trouble falling asleep?" },
  { category_id: 1, content: "Do you feel well rested in the morning?" },
  { category_id: 2, content: "Do you feel stressed?" },
  { category_id: 2, content: "Do you get angry easily?" },
  { category_id: 2, content: "Question stress 3?" },
  { category_id: 2, content: "Question stress 4?" }
]

questions.each do |question|
  seeded_question = Question.create!(
    content: question[:content],
    category_id: question[:category_id]
  )
end

puts "-------------------"
puts "seeding Answers"
puts "-------------------"

answers = [
  { category_id: 1, question_id: 1, content: "Yes", score: 1 },
  { category_id: 1, question_id: 1, content: "No", score: 0 },
  { category_id: 1, question_id: 2, content: "Yes", score: 1 },
  { category_id: 1, question_id: 2, content: "No", score: 0 },
  { category_id: 1, question_id: 3, content: "Yes", score: 1 },
  { category_id: 1, question_id: 3, content: "No", score: 0 },
  { category_id: 2, question_id: 4, content: "Yes", score: 2 },
  { category_id: 2, question_id: 4, content: "No", score: 0 },
  { category_id: 2, question_id: 4, content: "Maybe", score: 1 },
  { category_id: 2, question_id: 5, content: "Yes", score: 1 },
  { category_id: 2, question_id: 5, content: "No", score: 0 },
  { category_id: 2, question_id: 6, content: "Yes", score: 1 },
  { category_id: 2, question_id: 6, content: "No", score: 0 }
]

answers.each do |answer|
  seeded_answer = Answer.new(
    content: answer[:content]
  )
  seeded_answer.question = Question.find(answer[:question_id])
  seeded_answer.save
end
