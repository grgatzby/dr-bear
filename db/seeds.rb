# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.destroy_all
Question.destroy_all
Answer.destroy_all

puts "-------------------"
puts "seeding Categories"
puts "-------------------"

category_sleep = Category.create!(
  name: "Sleep"
)

puts "-------------------"
puts "seeding Questions"
puts "-------------------"

question_one = Question.new(content: "Do you sleep through the night?")
question_two = Question.new(content: "Do you have trouble falling asleep?")
question_three = Question.new(content: "Do you feel well rested in the morning?")

question_one.category = category_sleep
question_one.save
question_two.category = category_sleep
question_two.save
question_three.category = category_sleep
question_three.save

puts "-------------------"
puts "seeding Answers"
puts "-------------------"


Question.all.each do |question|
  answer_yes = Answer.new(content: "yes", score: 1)
  answer_no = Answer.new(content: "no", score: 0)
  answer_yes.question = question
  answer_no.question = question
  answer_yes.save
  answer_no.save
end
