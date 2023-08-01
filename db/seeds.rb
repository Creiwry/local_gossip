# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear out the existing data
MessageRecipient.destroy_all
PrivateMessage.destroy_all
GossipTag.destroy_all
Tag.destroy_all
Like.destroy_all
Comment.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 10),
    email: Faker::Internet.email,
    age: rand(18..70),
    city: City.all.sample
  )
end

# 10.times do
#   Tag.create!(title: Faker::Lorem.word)
# end

20.times do
  sentence = ""
  while sentence.length < 14
    word = Faker::Lorem.word
    break if (sentence.length + word.length + 1) > 14 # +1 for the space

    sentence += " " unless sentence.empty?
    sentence += word
  end

  gossip = Gossip.create!(
    title: sentence,
    content: Faker::Lorem.sentence(word_count: 20),
    user: User.all.sample
  )

  gossip.tags = Tag.all.sample(rand(1..3))
end

20.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    commentable: Gossip.all.sample,
    user: User.all.sample
  )
end

# 20.times do
#   Comment.create!(
#     content: Faker::Lorem.sentence(word_count: 10),
#     commentable: Comment.all.sample,
#     user: User.all.sample
#   )
# end

# 20.times do
#   likeable = [Gossip, Comment].sample.all.sample

#   Like.create!(
#     likeable: likeable,
#     user: User.all.sample
#   )
# end

# 30.times do
#   PrivateMessage.create!(
#     content: Faker::Lorem.sentence(word_count: 15),
#     sender: User.all.sample
#   )
# end

# PrivateMessage.all.each do |message|
#   recipients = User.all.sample(rand(1..5))

#   recipients.each do |recipient|
#     MessageRecipient.create!(
#       private_message: message,
#       recipient: recipient
#     )
#   end
# end
