require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'name' do
    it '未入力の場合、エラーが発生する' do
      user = build(:user, name: "")
      expect(user).to be_invalid
      expect(user.errors[:name]).to be_present
    end
  end

  describe 'email' do
    it '未入力の場合、エラーが発生する' do
      user = build(:user, email: "")
      expect(user).to be_invalid
      expect(user.errors[:email]).to be_present
    end

    it '同じアドレスが存在する場合、エラーが発生する' do
      create(:user, email: "exampleexample@example.com")
      same_address_user = build(:user, email: "exampleexample@example.com")
      expect(same_address_user).to be_invalid
      expect(same_address_user.errors[:email]).to be_present
    end

    it '大文字小文字を区別して登録できる' do
      create(:user, email: "abc@example.com")
      big_address_user = build(:user, email: "ABC@example.com")
      expect(big_address_user).to be_invalid
      expect(big_address_user.errors[:email]).to be_present
    end

    it 'メールアドレスの形式ではない場合、エラーが発生する' do
      wrong_address_user = build(:user, email: "no-address")
      expect(wrong_address_user).to be_invalid
      expect(wrong_address_user.errors[:email]).to be_present
    end
  end

  describe 'password' do
    it '未入力の場合、エラーが発生する' do
      user = build(:user, password: "")
      expect(user).to be_invalid
      expect(user.errors[:password]).to be_present
    end

    it 'password_confirmationと一致しない場合、エラーが発生する' do
      different_password_user = build(:user, password_confirmation: "different")
      expect(different_password_user).to be_invalid
      expect(different_password_user.errors[:password_confirmation]).to be_present
    end

    it '6文字未満の場合、エラーが発生する' do
      too_short_password = build(:user, password: "12345", password_confirmation: "12345")
      expect(too_short_password).to be_invalid
      expect(too_short_password.errors[:password]).to be_present
    end
  end
end
