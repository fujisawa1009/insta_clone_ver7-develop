require 'rails_helper'

RSpec.describe '投稿', type: :system do
  pending("調査中")
  let!(:user) { create(:user) }
  before do
    login_as(user)
  end
  describe '投稿' do
    it '投稿ができること' do
      pending("調査中")
      within '#header' do
        click_on '投稿'
      end
      fill_in '本文', with: 'てきすとです'
      attach_file '画像', Rails.root.join('spec', 'fixtures', 'dummy.jpg')
      click_on '登録する'
      expect(page).to have_content '投稿しました'
    end
  end

  describe '編集' do
    let!(:post) { create(:post, user: user) }
    it '編集ができること' do
      pending("調査中")
      visit "/posts/#{post.id}"
      find('#postDropdownMenuLink').click
      click_on '編集'
      fill_in '本文', with: 'てきすとです'
      click_on '更新する'
      expect(page).to have_content '投稿を更新しました'
      expect(page).to have_content 'てきすとです'
    end
  end

  describe '削除' do

    let!(:post) { create(:post, user: user) }
    it '削除ができること' do
      pending("調査中")
      visit "/posts/#{post.id}"
      find('#postDropdownMenuLink').click
      accept_confirm { click_on '削除' }
      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content post.body
    end
  end
end