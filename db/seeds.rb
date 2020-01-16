# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.find_by(email: 'customer@example.com')
  User.create(
      {
          name: 'Customer User',
          email: 'customer@example.com',
          password: 'password',
          role: 'customer'
      }
  )
end

unless User.find_by(email: 'support@example.com')
  User.create(
      {
          name: 'Support User',
          email: 'support@example.com',
          password: 'password',
          role: 'support'
      }
  )
end
