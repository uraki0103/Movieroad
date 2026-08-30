require 'rails_helper'

RSpec.describe Record, type: :model do
  it "必須項目が埋まっている場合、登録できる" do
    record = build(:record)
    expect(record).to be_valid
  end

  describe "theater" do
    it "未入力のまま、登録できる" do
      no_theater_record = build(:record, theater: nil)
      expect(no_theater_record).to be_valid
    end
  end

  describe "rating" do
    it "未入力の場合、登録に失敗する" do
      no_rating_record = build(:record, rating: nil)
      expect(no_rating_record).to be_invalid
    end

    it "数値が0未満の場合、登録に失敗する" do
      negative_rating_record = build(:record, rating: -0.1)
      expect(negative_rating_record).to be_invalid
    end

    it "数値が10.1以上の場合、登録に失敗する" do
      too_big_rating_record = build(:record, rating: 10.1)
      expect(too_big_rating_record).to be_invalid
    end

    it "0~10の間の数値の場合、登録にできる" do
      small_number_record = build(:record, rating: 0)
      expect(small_number_record).to be_valid
      big_number_record = build(:record, rating: 10)
      expect(big_number_record).to be_valid
    end
  end

  describe "watched_day" do
    it "未入力の場合、登録に失敗する" do
      no_watched_day_record = build(:record, watched_day: nil)
      expect(no_watched_day_record).to be_invalid
    end
  end

  describe "impression" do
    it "未入力のまま、登録できる" do
      no_impression_record = build(:record, impression: nil)
      expect(no_impression_record).to be_valid
    end

    it "1001文字以上入力した場合、登録に失敗する" do
      too_many_words_record = build(:record, impression: "あ" * 1001)
      expect(too_many_words_record).to be_invalid
    end
  end

  describe "memory_note" do
    it "未入力のまま、登録できる" do
      no_memory_note_record = build(:record, memory_note: nil)
      expect(no_memory_note_record).to be_valid
    end

    it "1001文字以上入力した場合、登録に失敗する" do
      too_many_words_note_record = build(:record, memory_note: "あ" * 1001)
      expect(too_many_words_note_record).to be_invalid
    end
  end

  describe "theater" do
    it "他のuser_idで登録されたtheaterを登録しようとした場合、登録に失敗する" do
      record = build(:record, theater: create(:theater))
      expect(record).to be_invalid
      expect(record.errors[:theater]).to be_present
    end
  end
end
