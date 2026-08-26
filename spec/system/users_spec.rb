require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '新規登録' do
    context 'フォームが正しく入力されている' do
      it 'ユーザー登録が成功する' do
        visit new_user_registration_path
        fill_in 'ユーザー名', with: 'name'
        fill_in 'メールアドレス', with: 'abc@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        click_button '登録する'
        expect(current_path).to eq records_path
      end
    end

    context 'メールアドレスが未入力' do
      it '登録失敗' do
        visit new_user_registration_path
        fill_in 'ユーザー名', with: 'name'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        click_button '登録する'
        expect(page).to have_content('メールアドレスを入力してください')
      end
    end

    context '登録済みのメールアドレスを入力する' do
      it '登録失敗' do
        create(:user, email: 'abcd@example.com')
        visit new_user_registration_path
        fill_in 'ユーザー名', with: 'name'
        fill_in 'メールアドレス', with: 'abcd@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        click_button '登録する'
        expect(page).to have_content('メールアドレスはすでに存在します')
      end
    end
  end
end
