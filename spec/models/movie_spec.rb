require 'rails_helper'

RSpec.describe Movie, type: :model do
  it "登録ができる" do
    movie = build(:movie)
    expect(movie).to be_valid
  end

  describe "title" do
    it "空欄の場合、登録に失敗する" do
      no_title = build(:movie, title: nil)
      expect(no_title).to be_invalid
    end
  end

  describe "tmdb_id" do
    # it "空欄の場合、登録に失敗する" do
    # no_tmdb_id = build(:movie, tmdb_id: nil)
    # expect(no_tmdb_id).to be_invalid
    # end

    it "既存の映画と重複する場合、登録に失敗する" do
      movie = create(:movie, tmdb_id: 5000)
      duplication_movie = build(:movie, tmdb_id: 5000)
      expect(duplication_movie).to be_invalid
    end
  end
end
