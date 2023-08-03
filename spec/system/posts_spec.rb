require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let(:user) { create(:user) }
  before do
    login_as(user)
  end
  describe '投稿' do
    it '投稿ができること' do
      visit '/posts/new'
      fill_in '本文', with: 'てきすとです'
      attach_file '画像', Rails.root.join('spec', 'fixtures', 'dummy.jpg')
      click_on '登録する'
      expect(page).to have_content '投稿しました'
    end
  end

  describe '編集' do
    let(:post) { create(:post, user: user) }
    it '投稿ができること' do
      visit "/posts/#{post.id}/edit"
      fill_in '本文', with: 'てきすとです'
      click_on '更新する'
      expect(page).to have_content '投稿しました'
    end
  end

  describe '詳細' do

  end

  describe '一覧' do

  end

  describe '削除' do

  end
end