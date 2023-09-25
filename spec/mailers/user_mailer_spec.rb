require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe '#like_post' do
    let(:post) { create(:post) }
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user_from: user, user_to: post.user, post: post).like_post }
    it '想定通りのメールが作成されている' do
      expect(mail.subject).to eq "#{user.username}さんがあなたの投稿にいいねしました"
      expect(mail.to).to eq [post.user.email]
      expect(mail.from).to eq ['instaclone@example.com']
      expect(mail.body.encoded).to match("#{user.username}さんがあなたの投稿にいいねしました")
    end
  end

  describe '#comment_post' do
    let(:comment) { create(:comment) }
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user_from: user, user_to: comment.post.user, comment: comment).comment_post }
    it '想定通りのメールが作成されている' do
      expect(mail.subject).to eq "#{user.username}さんがあなたの投稿にいいねしました"
      expect(mail.to).to eq [comment.post.user.email]
      pending expect(mail.from).to eq ['instaclone@example.com']
      expect(mail.body.encoded).to match("#{user.username}さんがあなたの投稿にいいねしました")
    end
  end

  describe '#follow' do
    let(:user_from) { create(:user) }
    let(:user_to) { create(:user) }
    let(:mail) { UserMailer.with(user_from: user_from, user_to: user_to).follow }
    it '想定通りのメールが作成されている' do
      expect(mail.subject).to eq "#{user_from.username}さんがあなたをフォローしました"
      expect(mail.to).to eq [user_to.email]
      expect(mail.from).to eq ['instaclone@example.com']
      expect(mail.body.encoded).to match("#{user_from.username}さんがあなたをフォローしました")
    end
  end
end
