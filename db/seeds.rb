# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.find_by(auth_token: '6FE0B3E972DBB9EEB96B5A441417FF26EF5DE07E')
  user = User.create(email: 'jose@test.com', username: 'jdavix')

  user.update_column(:auth_token, '6FE0B3E972DBB9EEB96B5A441417FF26EF5DE07E')

  puts 'Created test user with auth_token: 6FE0B3E972DBB9EEB96B5A441417FF26EF5DE07E'
end
