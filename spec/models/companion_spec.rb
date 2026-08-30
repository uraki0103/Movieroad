require 'rails_helper'

RSpec.describe Companion, type: :model do
  it "登録ができる" do
    companion = build(:companion)
    expect(companion).to be_valid
  end

  describe "comapnion_name" do
    it "未入力時、登録に失敗する" do
      no_companion = build(:companion, companion_name: nil)
      expect(no_companion).to be_invalid
    end

    it "51文字以上入力した場合、登録に失敗する" do
      too_many_words_comapanion = build(:companion, companion_name: "あ" * 51)
      expect(too_many_words_comapanion).to be_invalid
    end
  end
end
