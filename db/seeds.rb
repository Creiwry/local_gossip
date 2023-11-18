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

cities = [
  {name: "Tokyo", zip_code: "100-0001"},
  {name: "Delhi", zip_code: "110001"},
  {name: "Shanghai", zip_code: "200000"},
  {name: "Sao Paulo", zip_code: "01000-000"},
  {name: "Mumbai", zip_code: "400001"},
  {name: "Mexico City", zip_code: "06000"},
  {name: "Beijing", zip_code: "100000"},
  {name: "Cairo", zip_code: "11511"},
  {name: "Dhaka", zip_code: "1000"},
  {name: "Osaka", zip_code: "530-0001"},
  {name: "New York City", zip_code: "10001"},
  {name: "Karachi", zip_code: "74000"},
  {name: "Chongqing", zip_code: "400000"},
  {name: "Istanbul", zip_code: "34010"},
  {name: "Buenos Aires", zip_code: "C1000"},
  {name: "Kolkata", zip_code: "700001"},
  {name: "Lagos", zip_code: "100001"},
  {name: "Rio de Janeiro", zip_code: "20010-030"},
  {name: "Tianjin", zip_code: "300000"},
  {name: "Jakarta", zip_code: "10110"},
  {name: "Summit", zip_code: "07092"} # Newark is one of the major cities in New Jersey
]

cities.each do |city|
  City.create(name: city[:name], zip_code: city[:zip_code])
end

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'password',
    description: Faker::Lorem.sentence(word_count: 10),
    email: Faker::Internet.email,
    age: rand(18..70),
    city: City.all.sample,
    longitude: 2.4547635,
    latitude: 45.146842
  )
end

tags = [
  'awkward',
  'thisisserioustho',
  'lolnotme',
  'seriously??',
  'thatscool',
  'best',
  'music',
  'literature',
  'family'
]

tags.each do |tag|
  Tag.create!(title: tag)
end

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

20.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    commentable: Comment.all.sample,
    user: User.all.sample
  )
end

20.times do
  likeable = [Gossip, Comment].sample.all.sample

  Like.create!(
    likeable: likeable,
    user: User.all.sample
  )
end

30.times do
  PrivateMessage.create!(
    content: Faker::Lorem.sentence(word_count: 15),
    sender: User.all.sample
  )
end

PrivateMessage.all.each do |message|
  recipients = User.all.sample(rand(1..5))

  recipients.each do |recipient|
    MessageRecipient.create!(
      private_message: message,
      recipient: recipient
    )
  end
end
