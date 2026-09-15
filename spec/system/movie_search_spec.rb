require "rails_helper"

RSpec.describe "MovieSearch", type: :system, js: true do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "検索モーダルから映画を選択する" do
    context "検索結果が存在する" do
      before do
        stub_request(:get, "https://api.themoviedb.org/3/search/movie")
          .with(query: hash_including("query" => anything))
          .to_return(
            status: 200,
            body: {
              results: [
                {
                id: 100,
                title: "黒い絨毯",
                release_date: "1954-03-03",
                poster_path: "/test.jpg"
                }
              ]
            }.to_json,
          headers: { "Content-Type" => "application/json" }
        )
      end

      it "選択した映画のタイトルが入力欄に反映される" do
        visit new_record_path

        click_button "検索する"
        fill_in "query", with: "黒い絨毯"

        expect(page).to have_content("黒い絨毯")
      end

      it "選択した映画の情報がMovieとして保存される" do
      end
    end

    context "検索結果が0件" do
      before do
        stub_request(:get, "https://api.themoviedb.org/3/search/movie")
          .with(query: hash_including("query" => anything))
          .to_return(
            status: 200,
            body: { results: [] }.to_json,
          headers: { "Content-Type" => "application/json" }
        )
      end

      it "見つからないメッセージが表示される" do
        visit new_record_path

        click_button "検索する"
        fill_in "query", with: "黒い絨毯"

        expect(page).to have_content("該当する作品が見つかりませんでした。")
      end
    end
  end
end
