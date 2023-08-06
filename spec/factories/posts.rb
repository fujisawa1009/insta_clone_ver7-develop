# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :post do
    body { Faker::Lorem.sentence }
    user
    after(:build) do |post|
      post.images.attach(io: File.open('spec/fixtures/dummy.jpg'), filename: 'dummy.jpg', content_type: 'image/jpeg')
    end
  end
end
