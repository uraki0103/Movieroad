require "rails_helper"

RSpec.describe "TagManagement", type: :system, js: true do
  let(:user) { create(:user) }

  before { sign_in user }

  it "劇場タグを削除できる" do
    theater = create(:theater, user: user, theater_name: "ディノスシネマズ札幌")

    visit tags_path
    accept_confirm do
      find("form[action='#{tags_theater_path(theater)}']").find("button").click
    end

    expect(page).to have_content("ディノスシネマズ札幌を削除しました")
  end

  it "観た人タグを削除できる" do
    companion = create(:companion, user: user, companion_name: "ジェイソン・ステイサム")

    visit tags_path
    accept_confirm do
      find("form[action='#{tags_companion_path(companion)}']").find("button").click
    end

    expect(page).to have_content("ジェイソン・ステイサムを削除しました")
  end
end
