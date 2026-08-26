require 'rails_helper'

RSpec.describe 'Top', type: :system do
  let(:user) { create(:user) }

  describe 'TOP画面' do
    context 'ログイン済みの状態でTOPページにアクセスする' do
      it 'タイムラインに遷移する' do
        sign_in user
        visit root_path
        expect(current_path).to eq records_path
      end
    end

    context '未ログインの状態でTOPページにアクセスする' do
      it 'TOP画面が表示される' do
      visit root_path
      expect(current_path).to eq root_path
      expect(page).to have_content('Movie Road')
      end
    end
  end
end
