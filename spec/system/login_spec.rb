require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  let(:user) { create(:user) }
  describe 'ログイン機能' do
    context '入力情報に誤りがある場合' do
      it 'エラーメッセージが画面上に表示されること' do
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: 'wrong@example.com'
          fill_in 'パスワード', with: '12345678'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインに失敗しました'
      end
    end

    context '入力情報が正しい場合' do
      it 'ログインができること' do
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: '12345678'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインしました'
      end
    end
  end

  describe 'ログアウト機能' do
    before do
      login_as(user)
    end

    it 'ログアウトができること' do
      pending
      find("#header-avatar-dropdown").click
      accept_confirm { click_on 'ログアウト' }
      expect(page).to have_content 'ログアウトしました'
    end
  end

  describe 'ヘッダーのメニューの表示/非表示' do
    context 'ログイン状態の場合' do
      before do
        login_as(user)
      end

      it 'メニューの表示/非表示が適切であること' do
        visit '/'
        within '#header' do
          expect(page).not_to have_link 'ログイン', href: '/login'
          expect(page).not_to have_link 'サインアップ', href: '/signup'
          expect(page).to have_css '#header-avatar-dropdown'
        end
      end
    end

    context '未ログイン状態の場合' do
      it 'メニューの表示/非表示が適切であること' do
        visit '/'
        within '#header' do
          expect(page).to have_link 'ログイン', href: '/login'
          expect(page).to have_link 'サインアップ', href: '/signup'
          expect(page).not_to have_css '#header-avatar-dropdown'
        end
      end
    end
  end
end
