# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name:  "Example User",
#              email: "example@railstutorial.org",
#              password:              "foobar",
#              password_confirmation: "foobar",
#              admin:     true,
#              activated: true,
#              activated_at: Time.zone.now)

99.times do |n|
  first_name  = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = Faker::Internet.email
  password = "1234567"
  User.create!(first_name:  first_name,
               last_name: last_name,
               email: email,
               password: password,
               password_confirmation: password)
end

# 500.times do |n|
#   first_name  = Faker::Name.first_name
#   last_name  = Faker::Name.last_name
#   email = "dinhhuu-#{n+1}@gmail.com"
#   password = '1234567'
#   User.create!(first_name:  first_name,
#                last_name: last_name,
#                email: email,
#                password:              '1234567',
#                password_confirmation: '1234567')
# end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(2)
  content = Faker::Lorem.sentence(100)
  users.each { |user| user.newspapers.create!(title: title, content: content) }
end

#Comments

newspapers = Newspaper.take(50)
10.times do
  commenter = "Hanoi"
  body = Faker::Lorem.sentence(100)
  newspapers.each { |newspaper| newspaper.comments.create!(commenter: commenter, body: body, user_id: User.pluck(:id).sample)}
end

 
# end
# # Following relationships
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?