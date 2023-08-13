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
class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy

  validates :body, presence: true
  # 画像ファイルのみ, 5MBまで
  validates :images, presence: true,
                     blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  # ransackの4系からモデルに許可リストが必要
  def self.ransackable_attributes(_auth_object = nil)
    ['body']
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments user]
  end
end
