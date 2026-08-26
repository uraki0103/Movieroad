require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'アドレス、パスワードが正しい' do
      it 'ログインに成功する' do
        visit new_user_session_path
        save_page
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(current_path).to eq records_path
      end
    end

    context 'パスワードが誤り' do
      it 'ログインに失敗する' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'wrongpass'
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリックする' do
      it 'ログアウトに成功する' do
        sign_in user
        visit records_path
        click_button 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end
end
