puts 'Start inserting seed "posts" ...'
User.limit(10).each do |user|
  post = user.posts.create(body: Faker::Hacker.say_something_smart)
  post.images.attach(io: File.open('db/fixtures/dummy.jpg'), filename: 'dummy')
  post.images.attach(io: File.open('db/fixtures/dummy.jpg'), filename: 'dummy')
  post.images.attach(io: File.open('db/fixtures/dummy.jpg'), filename: 'dummy')
  puts "post#{post.id} has created!"
end