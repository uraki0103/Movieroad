require 'rails_helper'

RSpec.describe "TagsCompanions", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  before do
    host! "localhost"
  end

  describe "DELETE /tags/companions/:id" do
    it "自分の観た人タグを削除できる" do
      companion = create(:companion, companion_name: "ブルース・ウィルス", user: user)
      delete tags_companion_path(companion)
      expect(user.companions.where(companion_name: "ブルース・ウィルス")).to be_empty
    end

    it "他人の観た人タグは削除できない" do
      other_user = create(:user)
      other_companion = create(:companion, user: other_user)
      expect { delete tags_companion_path(other_companion) }.not_to change(Companion, :count)
    end
  end
end
