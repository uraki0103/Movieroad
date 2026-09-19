require "rails_helper"

RSpec.describe "RecordsSearch", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  before do
    host! "localhost"
  end

  describe "GET /records/search" do
    let!(:main_record) do
      create(:record, user: user, movie: create(:movie, title: "アイアンマン"), watched_day: "2026-08-01")
    end
    let!(:other_record) do
      create(:record, user: user, movie: create(:movie, title: "メタルマン"), watched_day: "2026-06-01")
    end

    it "タイトルの部分一致で検索ができる" do
      get search_records_path, params: { q: { movie_title_cont: "アイアン" } }

      expect(response.body).to include("アイアンマン")
      expect(response.body).not_to include("メタルマン")
    end

    it "鑑賞日(from)で検索できる" do
      get search_records_path, params: { q: { watched_day_gteq: "2026-07-01" } }

      expect(response.body).to include("アイアンマン")
      expect(response.body).not_to include("メタルマン")
    end

    it "鑑賞日(to)で検索できる" do
      get search_records_path, params: { q: { watched_day_lteq: "2026-07-01" } }

      expect(response.body).not_to include("アイアンマン")
      expect(response.body).to include("メタルマン")
    end

    it "該当しない場合、メッセージが表示される" do
      get search_records_path, params: { q: { movie_title_cont: "キャプテンアメリカ" } }

      expect(response.body).to include("該当する記録が見つかりませんでした")
    end

    it "他の人の記録が結果に含まれない" do
      another_user = create(:user)
      create(:record, user: another_user, movie: create(:movie, title: "アイアンマン2"))

      get search_records_path, params: { q: { movie_title_cont: "アイアンマン" } }

      expect(response.body).to include("アイアンマン")
      expect(response.body).not_to include("アイアンマン2")
    end
  end
end
