require 'rails_helper'

RSpec.describe Theater, type: :model do
  it "登録ができる" do
    theater = build(:theater)
    expect(theater).to be_valid
  end

  describe "theater_name" do
    it "空欄の場合、登録に失敗する" do
      no_theater = build(:theater, theater_name: nil)
      expect(no_theater).to be_invalid
    end

    it "51文字以上の場合、失敗する" do
      too_many_words_theater = build(:theater, theater_name: "あ" * 51)
      expect(too_many_words_theater).to be_invalid
    end
  end

  it "削除時、関連する記録からもtheater_idが削除されている" do
    user = create(:user)
    theater = create(:theater, user: user)
    record = create(:record, theater: theater, user: user)

    theater.destroy

    expect(record.reload.theater_id).to be_nil
  end
end
