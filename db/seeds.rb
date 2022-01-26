# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

aiko = User.create!(email: 'aiko@gmail.com', password: 'password')
kiyo = User.create!(email: 'kiyo@gmail.com', password: 'password')

5.times do
  aiko.posts.create!(
    title: Faker::Lorem.sentence(word_count: 5),
    content: Faker::Lorem.sentence(word_count: 20)
  )
end

5.times do
  kiyo.posts.create!(
    title: Faker::Lorem.sentence(word_count: 5),
    content: Faker::Lorem.sentence(word_count: 20)
  )
end
