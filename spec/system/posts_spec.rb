require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let!(:user) { create(:user) }
  before do
    login_as(user)
  end
  describe '投稿' do
    it '投稿ができること' do
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
      visit "/posts/#{post.id}"
      find('#postDropdownMenuLink').click
      accept_confirm { click_on '削除' }
      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content post.body
    end
  end

  describe 'ページネーション' do
    let!(:post) { create(:post, created_at: Time.current.yesterday) }
    before do
      create_list(:post, 15)
    end

    it '16件目のポストは1ページ目に表示されていないこと' do
      visit '/posts'
      expect(page).not_to have_css("#post_#{post.id}")
    end
  end

  describe '検索' do
    describe '投稿の本文での検索' do
      let!(:post_a) { create(:post, body: 'おはよう') }
      let!(:post_b) { create(:post, body: 'こんにちは') }
      let!(:post_c) { create(:post, body: 'こんばんは') }
      before do
        User.all.each { |u| user.follow(u) }
      end
      it '投稿の本文での検索ができること' do
        visit '/posts'
        find('#search-icon').click
        within '#searchModal' do
          fill_in '投稿の本文', with: 'おは'
          click_on '検索'
        end
        expect(page).to have_css "#post_#{post_a.id}"
        expect(page).not_to have_css "#post_#{post_b.id}"
        expect(page).not_to have_css "#post_#{post_c.id}"
      end
    end

    describe 'コメントでの検索' do
      let!(:post_a) do
        post = create(:post)
        create(:comment, post: post, body: 'GoodMorning')
        post
      end
      let!(:post_b) do
        post = create(:post)
        create(:comment, post: post, body: 'Hello')
        post
      end
      let!(:post_c) do
        post = create(:post)
        create(:comment, post: post, body: 'GoodEvening')
        post
      end
      before do
        User.all.each { |u| user.follow(u) }
      end
      it 'コメントでの検索ができること' do
        visit '/posts'
        find('#search-icon').click
        within '#searchModal' do
          fill_in 'コメント', with: 'GoodMorning'
          click_on '検索'
        end
        expect(page).to have_css "#post_#{post_a.id}"
        expect(page).not_to have_css "#post_#{post_b.id}"
        expect(page).not_to have_css "#post_#{post_c.id}"
      end
    end

    describe '投稿者のユーザー名での検索' do
      let!(:post_a) do
        user = create(:user, username: 'taro')
        create(:post, user: user)
      end
      let!(:post_b) do
        user = create(:user, username: 'jiro')
        create(:post, user: user)
      end
      let!(:post_c) do
        user = create(:user, username: 'saburo')
        create(:post, user: user)
      end
      before do
        User.all.each { |u| user.follow(u) }
      end
      it '投稿者のユーザー名での検索ができること' do
        visit '/posts'
        find('#search-icon').click
        within '#searchModal' do
          fill_in 'ユーザー名', with: 'taro'
          click_on '検索'
        end
        expect(page).to have_css "#post_#{post_a.id}"
        expect(page).not_to have_css "#post_#{post_b.id}"
        expect(page).not_to have_css "#post_#{post_c.id}"
      end
    end
  end
end