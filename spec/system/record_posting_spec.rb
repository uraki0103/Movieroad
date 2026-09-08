require "rails_helper"

RSpec.describe "RecordPosting", type: :system, js: true do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "新規作成" do
    context "必須項目が全て入力されている" do
      it "登録に成功する" do
        visit new_record_path

        fill_in "映画タイトル", with: "ピラニア10"
        fill_in "record_rating", with: "7.5"
        watched_day = find("#record_watched_day")
        watched_day.click
        watched_day.send_keys("08/01/2026")
        watched_day.send_keys(:tab)
        click_button "作成"

        expect(page).to have_current_path(records_path)
        expect(page).to have_content('記録を保存しました')

        record = Record.last
        expect(record.movie.title).to eq("ピラニア10")
        expect(record.rating).to eq(7.5)
        expect(record.watched_day).to eq(Time.zone.parse("2026-08-01"))
      end
    end

    context "映画タイトルが未入力" do
      it "登録に失敗する" do
        visit new_record_path

        fill_in "映画タイトル", with: ""
        fill_in "record_rating", with: "7.5"
        watched_day = find("#record_watched_day")
        watched_day.click
        watched_day.send_keys("08/01/2026")
        watched_day.send_keys(:tab)
        click_on "作成"

        expect(page).to have_content("映画タイトルを入力してください")
      end
    end

    context "画像以外の全項目が入力されている" do
      it "登録に成功し、感想、観賞場所、観た人が紐づけられている" do
        visit new_record_path

        fill_in "映画タイトル", with: "ザ・グリード5"
        watched_day = find("#record_watched_day")
        watched_day.click
        watched_day.send_keys("08/01/2026")
        watched_day.send_keys(:tab)
        fill_in "観賞場所", with: "サツゲキ"
        find("[data-companion-picker-target='input']").set("マイケル・マイヤーズ")
        find("[data-companion-picker-target='input']").native.send_keys(:enter)
        fill_in "record_impression", with: "面白かった"
        fill_in "record_memory_note", with: "ポップコーン"
        click_button "作成"

        expect(page).to have_content("記録を保存しました")
        expect(page).to have_current_path(records_path)

        record = Record.last
        expect(record.theater.theater_name).to eq("サツゲキ")
        expect(record.companions.pluck(:companion_name)).to eq([ "マイケル・マイヤーズ" ])
        expect(record.impression).to eq("面白かった")
        expect(record.memory_note).to eq("ポップコーン")
      end
    end

    context "思い出の写真を複数アップロード" do
      it "全ての写真が保存されている" do
        visit new_record_path

        fill_in "映画タイトル", with: "ミザリーの復活"
        fill_in "record_rating", with: "7.5"
        watched_day = find("#record_watched_day")
        watched_day.click
        watched_day.send_keys("08/01/2026")
        watched_day.send_keys(:tab)

        attach_file "record[memory_photos][]", [
          Rails.root.join("spec/fixtures/files/test1.jpg"),
          Rails.root.join("spec/fixtures/files/test2.jpg")
        ]
        click_button "作成"

        expect(page).to have_content("記録を保存しました")
        record = Record.last
        expect(record.memory_photos.count).to eq(2)
      end
    end
  end

  describe "編集" do
    it "内容の変更が正しく反映される" do
      record = create(:record, user: user)

      visit edit_record_path(record)

      fill_in "record_impression", with: "つまらなかった"
      fill_in "record_rating", with: "2.5"
      click_button "更新する"

      expect(page).to have_current_path(records_path)
      expect(page).to have_content("記録を更新しました")

      record.reload
      expect(record.rating).to eq(2.5)
      expect(record.impression).to eq("つまらなかった")
    end
  end
end
