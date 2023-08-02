require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  describe 'ユーザー登録機能' do
    context '入力情報に誤りがある場合' do
      it 'エラーメッセージが画面上に表示されること' do
        visit '/signup'
        fill_in 'ユーザー名', with: 'やまだたろう'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード確認', with: '12345678'
        click_on '登録する'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context '入力情報が正しい場合' do
      it 'ユーザー登録が行われること' do
        visit '/signup'
        fill_in 'ユーザー名', with: 'やまだたろう'
        fill_in 'メールアドレス', with: 'yamada@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード確認', with: '12345678'
        click_on '登録する'
        expect(page).to have_content 'ユーザー登録が完了しました'
      end
    end
  end
end