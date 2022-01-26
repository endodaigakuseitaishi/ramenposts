# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shunta = User.create!(email: 'shnta@gmail.com', password: 'password')
kiyoto = User.create!(email: 'kiyoto@gmail.com', password: 'password')

5.times do
  shunta.posts.create!(
    title: Faker::Lorem.sentence(word_count: 5),
    content: Faker::Lorem.sentence(word_count: 20)
  )
end

5.times do
  kiyoto.posts.create!(
    title: Faker::Lorem.sentence(word_count: 5),
    content: Faker::Lorem.sentence(word_count: 20)
  )
end
