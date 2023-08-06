require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  let(:user) { build(:user, email: 'user@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'ログイン機能' do
    context '入力情報に誤りがある場合' do
      it 'エラーメッセージが画面上に表示されること' do
        pending("調査中")
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: 'wrong@example.com'
          fill_in 'パスワード', with: 'wrongpassword'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインに失敗しました'
      end
    end

    context '入力情報が正しい場合' do
      it 'ログインができること' do
        pending("調査中")
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password123'
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
      pending("調査中")
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
        pending("調査中")
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
        pending("調査中")
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