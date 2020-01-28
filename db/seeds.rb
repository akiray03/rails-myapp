# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.find_by(email: 'customer@example.com')
  puts "* User(customer@example.com) is already exists."
else
  User.create(
      {
          name: 'Customer User',
          email: 'customer@example.com',
          password: 'password',
          role: 'customer'
      }
  )
  puts "* User(customer@example.com) is created."
end

if User.find_by(email: 'support@example.com')
  puts "* User(support@example.com) is already exists."
else
  User.create(
      {
          name: 'Support User',
          email: 'support@example.com',
          password: 'password',
          role: 'support'
      }
  )
  puts "* User(support@example.com) is created."
end
