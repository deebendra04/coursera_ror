# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.all.each do |user|
    5.times do |i|
      Course.create!(
        title: "Course Title #{i + 1} by #{user.name}",
        description: "This is a detailed description of Course #{i + 1} created by #{user.name}.",
        price: (rand(100..1000) / 10.0),  # Generates random prices between 10 and 100
        user_id: user.id
      )
    end
  end

  puts "Created 20 Courses"