# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

p "Starting to seed ...."

# names = [ "user1", "user2", "user3", "user4", "user5" ]
names = Array.new(10, "_")
  .map! do |name|
    Faker::Name.first_name().downcase
  end
puts names

# user
names.each do |name|
  user = User.new(
    username: name,
    email: "#{name}@example.com",
    password: "123456",
    password_confirmation: "123456"
  )
  user.save!
end

# new post
names.each do |name|
  user = User.find_by(username: name)
  user_new_post = user.posts.new({ body: "Hi, im #{name.capitalize}. #{Faker::Lorem.sentence(word_count: 10)}. This is faker generated." })
  user_new_post.save!
end


p "Completed seeding."
