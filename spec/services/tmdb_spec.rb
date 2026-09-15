require "rails_helper"

RSpec.describe Tmdb do
  describe "映画タイトル検索" do
    context "存在する映画タイトルで検索する" do
      let(:query) { "冷たい熱帯魚" }
      before do
        stub_request(:get, "https://api.themoviedb.org/3/search/movie")
          .with(query: hash_including("query" => query))
          .to_return(
            status: 200,
            body: {
              results: [
              { id: 100, title: "冷たい熱帯魚", release_date: "1987-09-18", poster_path: "/test.jpg" }
              ]
            }.to_json,
            headers: { "Content-Type" => "application/json" }
          )
      end

      it "検索結果の配列が返る" do
        results = described_class.new.search_movies(query)
        expect(results.first[:title]).to eq("冷たい熱帯魚")
      end
    end

    context "空欄のままで検索する" do
      let(:query) { "" }
      before do
        stub_request(:get, "https://api.themoviedb.org/3/search/movie")
            .with(query: hash_including("query" => query))
            .to_return(
              status: 200,
              body: { results: [] }.to_json,
              headers: { "Content-Type" => "application/json" }
            )
      end

      it "空の配列を返す" do
        results = described_class.new.search_movies(query)
        expect(results).to eq([])
      end
    end

    context "TMDbでエラーが発生" do
      let(:query) { "" }
      before do
        stub_request(:get, "https://api.themoviedb.org/3/search/movie")
          .with(query: hash_including("query" => query))
          .to_return(status: 500)
      end

      it "空の配列を返す" do
        results = described_class.new.search_movies(query)
        expect(results).to eq([])
      end
    end
  end
end
