# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
include Faker

20.times do
  Faker::Config.random = Random.new(42)
  Post.create(name: Faker::Game.title, feature_img: Faker::LoremPixel.image,
    content: Faker::Lorem.paragraphs, summary: Faker::Lorem.paragraph(sentence_count: 2))
end