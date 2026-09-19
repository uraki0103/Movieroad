require "rails_helper"

RSpec.describe "Timeline", type: :system do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "タイムライン画面" do
    context "記録1件も存在しない" do
      it "空の状態のメッセージが表示されている" do
        visit records_path

        expect(page).to have_content("記録がありません")
      end
    end

    context "記録が複数年にまたがる" do
      let!(:this_year_record) do
        create(:record, user: user, watched_day: Time.zone.now)
      end
      let!(:last_year_record) do
        create(:record, user: user, watched_day: 1.year.ago)
      end

      before do
        visit records_path
      end

      it "記録が年ごとに分かれ、最新年が開かれ過去年は折りたたまれて表示されている" do
        expect(page).to have_content(this_year_record.movie.title)

        current_year_details = find("details", text: "#{Time.zone.now.year}年")
        last_year_details = find("details", text: "#{1.year.ago.year}年")

        expect(current_year_details[:open]).not_to be_nil
        expect(last_year_details[:open]).to be_nil
      end

      it "折りたたまれた年をクリックすると展開する" do
        last_year_details = find("details", text: "#{1.year.ago.year}年")
        last_year_details.find("summary").click

        expect(last_year_details[:open]).to eq("open")
        expect(page).to have_content(last_year_record.movie.title)
      end
    end

    context "記録をクリックする" do
      it "記録詳細画面に遷移する" do
        record = create(:record, user: user)
        visit records_path
        click_link record.movie.title, match: :first

        expect(page).to have_current_path(record_path(record))
      end
    end
  end
end
