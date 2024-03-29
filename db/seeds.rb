# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# if Rails.env.development?
  puts "-------------------"
  puts "resetting Database"
  puts "-------------------"
  Answer.destroy_all
  Question.destroy_all
  Category.destroy_all
  Result.destroy_all
  User.destroy_all
# end

puts "-------------------"
puts "seeding Users"
puts "-------------------"

User.create!(
  first_name: "Crash",
  last_name: "Dummy",
  email: "crash@dummy.org",
  password: "123456"
)

User.create!(
  first_name: "Teddy",
  last_name: "Bear",
  email: "bear1@user.org",
  password: "123456"
)
puts "seeded user bear1@user.org"

sample_users = [
  { first_name: "Marinos", last_name: "Veisllari" },
  { first_name: "Ilan", last_name: "Okker" },
  { first_name: "Ian", last_name: "Kelly" },
  { first_name: "Guillaume", last_name: "Cazals" },
  { first_name: "Pedro", last_name: "Vilarinho" },
]

sample_users.each do |user|
  User.create(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: "#{user[:first_name].downcase}@user.org",
    password: "123456"
  )
  puts "seeded user #{user[:first_name].downcase}@user.org"
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
  { name: "Energy", description: "Energy is a crucial aspect of overall health and well-being. It refers to the physical and mental ability to engage in activities and perform tasks throughout the day. The presence or absence of energy can have significant impacts on an individual's physical health, mental health, and daily functioning." },
  { name: "Heart", description: "The heart is a vital organ that is responsible for circulating blood throughout the body. It is essential for maintaining overall health and wellness. However, various factors can impact heart health, including lifestyle choices, genetics, and underlying health conditions.  Preventative measures can help promote heart health, such as maintaining a healthy diet, engaging in regular physical activity, avoiding smoking, and managing stress levels. Regular check-ups with a healthcare provider can also help monitor heart health and identify any potential issues before they become more serious." },
  { name: "Cholesterol", description: "Cholesterol is a type of fat that is produced by the liver and is essential for various bodily functions. However, when cholesterol levels in the blood become too high, it can contribute to the development of various health conditions, including heart disease.
    High cholesterol levels can result from various factors, including genetics, diet, and lifestyle choices. A diet high in saturated and trans fats can contribute to high cholesterol levels, as can a lack of physical activity and smoking." }
]

id_cat = []
categories.each do |category|
  seeded_category = Category.create!(
    name: category[:name],
    description: category[:description]
  )
  id_cat.push(seeded_category.id)
  puts "seeded category #{seeded_category.id}, #{seeded_category.name}"
end

puts "-------------------"
puts "seeding Questions"
puts "-------------------"

# input questions content for each category
questions = [
  # Sleep
  { category_id: id_cat[0], content: "Do you sleep through the night?" },
  { category_id: id_cat[0], content: "Do you have trouble falling asleep?" },
  { category_id: id_cat[0], content: "Do you feel well rested in the morning?" },
  # Stress
  { category_id: id_cat[1], content: "Do you feel stressed on a daily basis?" },
  { category_id: id_cat[1], content: "Do you get agitated easily over things outside your control?" },
  { category_id: id_cat[1], content: "Do you find it difficult to relax?" },
  # Energy
  { category_id: id_cat[2], content: "Is your overall energy level throughout the day consistently high?" },
  { category_id: id_cat[2], content: "Do you engage in physical activity or exercise?" },
  { category_id: id_cat[2], content: "Do you have a balanced diet and eat meals regularly throughout the day?" },
  # Heart
  { category_id: id_cat[3], content: "Have you ever experienced chest pain or discomfort?" },
  { category_id: id_cat[3], content: "Do you smoke or use tobacco products?" },
  { category_id: id_cat[3], content: "Do you have a family history of heart disease?" },
  # Cholesterol
  { category_id: id_cat[4], content: "Have you ever had your cholesterol levels checked?" },
  { category_id: id_cat[4], content: "Do you have a family history of high cholesterol?" },
  { category_id: id_cat[4], content: "What is your typical diet like? Do you consume a lot of high-fat or high-cholesterol foods?" },
]

id_q = []
questions.each do |question|
  seeded_question = Question.create!(
    content: question[:content],
    category_id: question[:category_id]
  )
  id_q.push(seeded_question.id)
  puts "seeded question #{seeded_question.id}, [ #{seeded_question.category.name}--->] #{seeded_question.content}"
end

puts "-------------------"
puts "seeding Answers"
puts "-------------------"

# input answers content and score for each category/question
answers = [
  # Sleep
  { category_id: id_cat[0], question_id: id_q[0], content: "Yes", score: 2 }, #
  { category_id: id_cat[0], question_id: id_q[0], content: "No", score: 0 },
  { category_id: id_cat[0], question_id: id_q[0], content: "Sometimes", score: 1 },
  { category_id: id_cat[0], question_id: id_q[1], content: "Yes", score: 1 }, #
  { category_id: id_cat[0], question_id: id_q[1], content: "No", score: 0 },
  { category_id: id_cat[0], question_id: id_q[2], content: "Yes", score: 1 }, #
  { category_id: id_cat[0], question_id: id_q[2], content: "No", score: 0 },
  # Stress
  { category_id: id_cat[1], question_id: id_q[3], content: "Yes", score: 1 }, #
  { category_id: id_cat[1], question_id: id_q[3], content: "No", score: 0 },
  { category_id: id_cat[1], question_id: id_q[4], content: "Yes", score: 2 }, #
  { category_id: id_cat[1], question_id: id_q[4], content: "No", score: 0 },
  { category_id: id_cat[1], question_id: id_q[4], content: "Sometimes", score: 1 },
  { category_id: id_cat[1], question_id: id_q[5], content: "Yes", score: 1 }, #
  { category_id: id_cat[1], question_id: id_q[5], content: "No", score: 0 },
  # Energy
  { category_id: id_cat[2], question_id: id_q[6], content: "Yes", score: 1 }, #
  { category_id: id_cat[2], question_id: id_q[6], content: "No", score: 0 },
  { category_id: id_cat[2], question_id: id_q[7], content: "Yes", score: 1 }, #
  { category_id: id_cat[2], question_id: id_q[7], content: "No", score: 0 },
  { category_id: id_cat[2], question_id: id_q[8], content: "Yes", score: 2 }, #
  { category_id: id_cat[2], question_id: id_q[8], content: "No", score: 0 },
  { category_id: id_cat[2], question_id: id_q[8], content: "Sometimes", score: 1 },
  # Heart
  { category_id: id_cat[3], question_id: id_q[9], content: "Yes", score: 1 }, #
  { category_id: id_cat[3], question_id: id_q[9], content: "No", score: 0 },
  { category_id: id_cat[3], question_id: id_q[10], content: "Yes", score: 1 }, #
  { category_id: id_cat[3], question_id: id_q[10], content: "No", score: 0 },
  { category_id: id_cat[3], question_id: id_q[11], content: "Yes", score: 1 }, #
  { category_id: id_cat[3], question_id: id_q[11], content: "No", score: 0 },
  # Cholesterol
  { category_id: id_cat[4], question_id: id_q[12], content: "Yes", score: 1 },
  { category_id: id_cat[4], question_id: id_q[12], content: "No", score: 0 },
  { category_id: id_cat[4], question_id: id_q[13], content: "Yes", score: 1 },
  { category_id: id_cat[4], question_id: id_q[13], content: "No", score: 0 },
  { category_id: id_cat[4], question_id: id_q[14], content: "Yes", score: 2 },
  { category_id: id_cat[4], question_id: id_q[14], content: "No", score: 0 },
  { category_id: id_cat[2], question_id: id_q[14], content: "Sometimes", score: 1 }
]

answers.each do |answer|
  seeded_answer = Answer.create!(
    content: answer[:content],
    score: answer[:score],
    question_id: answer[:question_id]
  )
  puts "seeded answer #{seeded_answer.id}, [ #{seeded_answer.question.category.name} ] [ #{seeded_answer.question.content}--->] #{seeded_answer.content}"
end

puts "-------------------"
puts "seeding Nutrients"
puts "-------------------"

# implement nutrients name and description
nutrients = [
  { name: "Vitamin A",
    description: "Vitamin A helps in vision, bone growth, reproduction, growth of epithelium",
    nutri_code: "320" },

  { name: "Vitamin B1 (Thiamin)",
    description: "Vitamin B1 helps some enzymes work properly, helps break down sugars in the diet",
    nutri_code: "404" },

    { name: "Vitamin B2 (Riboflavin)",
      description: "Riboflavin works to reduce oxidative stress and inflammation of nerves",
    nutri_code: "405" },

  { name: "Vitamin B3 (Niacin)",
    description: "Vitamin B3 helps keep your nervous system, digestive system and skin healthy",
    nutri_code: "406" },

  { name: "Vitamin B6",
    description: "Is crucial for brain and nervous system development and immune health.",
    nutri_code: "415" },

  { name: "Vitamin B12",
    description: "Important for red blood cells, cell metabolism, nerves, and DNA production.",
    nutri_code: "418" },

  { name: "Vitamin C",
    description: "Functions as an antioxidant by protecting cells from free radicals.",
    nutri_code: "401" },

  { name: "Calcium",
    description: "Calcium is vital for strong bones, heart, muscle, and nerve function.",
    nutri_code: "301" },

  { name: "Vitamin D",
    description: "Helps absorb and retain calcium and phosphorus for bone building.",
    nutri_code: "328" },

  { name: "Vitamin E",
    description: "Promotes healthy skin and eyes, and strengthens immune system defense.",
    nutri_code: "323" },

  { name: "Folate",
    description: "Important for red blood cell formation and healthy cell growth and function",
    nutri_code: "417" },

  { name: "Vitamin K",
    description: "Essential for blood clotting and protein production for bone building.",
    nutri_code: "430" },

  { name: "Magnesium",
    description: "Essential for muscle, nerve, blood function, protein, and DNA synthesis.",
    nutri_code: "304" },

  { name: "Potassium",
    description: "Regulates fluid balance and helps maintain normal fluid levels inside cells.",
    nutri_code: "306" },

  { name: "Sodium",
    description: "Enables nerve impulses, muscle contraction, fluid balance, and mineral regulation.",
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
  puts "seeded nutrient #{seeded_nutrient.id}, #{seeded_nutrient.name}"
end

puts "-------------------"
puts "seeding Category_Nutrients"
puts "-------------------"
# input category_nutrients min_score and max_score
# nutri 0 - 4 for sleep ~ cat 0
category_nutrients = [
  # Sleep
  { category_id: id_cat[0], nutrient_id: id_nutr[0], min_score: 1, max_score: 4 },
  { category_id: id_cat[0], nutrient_id: id_nutr[1], min_score: 3, max_score: 4 },
  { category_id: id_cat[0], nutrient_id: id_nutr[2], min_score: 4, max_score: 4 },
  # Stress
  { category_id: id_cat[1], nutrient_id: id_nutr[3], min_score: 1, max_score: 4 },
  { category_id: id_cat[1], nutrient_id: id_nutr[4], min_score: 3, max_score: 4 },
  { category_id: id_cat[1], nutrient_id: id_nutr[5], min_score: 4, max_score: 4 },
  # Energy
  { category_id: id_cat[2], nutrient_id: id_nutr[6], min_score: 1, max_score: 4 },
  { category_id: id_cat[2], nutrient_id: id_nutr[7], min_score: 3, max_score: 4 },
  { category_id: id_cat[2], nutrient_id: id_nutr[8], min_score: 4, max_score: 4 },
  # Heart
  { category_id: id_cat[3], nutrient_id: id_nutr[9], min_score: 1, max_score: 3 },
  { category_id: id_cat[3], nutrient_id: id_nutr[10], min_score: 2, max_score: 3 },
  { category_id: id_cat[3], nutrient_id: id_nutr[11], min_score: 3, max_score: 3 },
  # Cholesterol
  { category_id: id_cat[4], nutrient_id: id_nutr[12], min_score: 1, max_score: 4 },
  { category_id: id_cat[4], nutrient_id: id_nutr[13], min_score: 3, max_score: 4 },
  { category_id: id_cat[4], nutrient_id: id_nutr[14], min_score: 4, max_score: 4 }
]

category_nutrients.each do |category_nutrient|
  seeded_category_nutrient = CategoryNutrient.create!(
    min_score: category_nutrient[:min_score],
    max_score: category_nutrient[:max_score],
    category_id: category_nutrient[:category_id],
    nutrient_id: category_nutrient[:nutrient_id]
  )
  puts "seeded category_nutrient #{seeded_category_nutrient.id}"
end
