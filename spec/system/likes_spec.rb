require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  let!(:user) { create(:user) }
  before do
    login_as(user)
  end
  describe 'いいねといいねの解除' do
    let!(:post) { create(:post, user: user) }
    it 'いいねといいねの解除ができること' do
      visit '/posts'
      expect {
        within "#like_post_#{post.id}" do
          find('.btn-like').click
        end
        sleep 0.1
      }.to change { Like.count }.by(1)

      expect {
        within "#like_post_#{post.id}" do
          find('.btn-unlike').click
        end
        sleep 0.1
      }.to change { Like.count }.by(-1)
    end
  end
end
