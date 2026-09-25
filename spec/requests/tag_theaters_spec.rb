require 'rails_helper'

RSpec.describe "TagTheaters", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  before do
    host! "localhost"
  end

  describe "DELETE /tags/theaters/:id" do
    it "自分の劇場タグを削除できる" do
      theater = create(:theater, user: user)
      delete tags_theater_path(theater)
      expect(Theater.exists?(theater.id)).to be(false)
    end

    it "他人の劇場タグは削除できない" do
      other_user = create(:user)
      other_theater = create(:theater, user: other_user)
      expect { delete tags_theater_path(other_theater) }.not_to change(Theater, :count)
    end
  end
end
