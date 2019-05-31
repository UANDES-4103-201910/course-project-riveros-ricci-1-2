# Create several normal Users
normal_users = []
30.times do |i|
  username = Faker::Internet.user_name + i.to_s
  normal_users << User.create(
    username: username,
    email: "#{username}@mail.com",
    password: '123456'
  )
  print '.' if i % 3 == 0
end
puts "Created #{normal_users.count} users"

posts = []
normal_users.each do |user|
  # Each user will have a profile
  UserProfile.update(
    user_id: user.id,
    name: Faker::Name.name.to_s,
    bio: Faker::Lorem.sentence(15).to_s
  )
  # Each user will have between 0 and 3 posts
  rand(4).times do |i|
    posts << Post.create(
      user_id: user.id,
      description: Faker::Lorem.sentence(4).to_s,
      content: Faker::Lorem.paragraph_by_chars(256, true).to_s,
      city: 'Santiago',
      country: 'Chile'
    )
  end
end
puts "Created #{posts.count} posts"

# All posts will have between 0 - 8 comments
posts.each do |p|
  rand(9).times do
    user = normal_users[rand(normal_users.length)]
    p.comments.create(
      user_id: user.id,
      content: Faker::TvShows::TwinPeaks.quote.to_s
    )
  end
end

