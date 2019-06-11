# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Minimum to create users
UserStatus.new(name: 'Active', comment: 'User is active').save
UserStatus.new(name: 'Blacklisted', comment: 'User is in the blacklist').save
UserStatus.new(name: 'Banned', comment: 'User is banned from the site').save
User.new(username: 'Admin', email: 'admin@admin.com', password: '123456',
         is_admin: true, is_superadmin: true, user_status_id: 1, karma: 0).save
