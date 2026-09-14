class Tmdb
  BASE_URL = "https://api.themoviedb.org/3"

  def initialize
    @connection = Faraday.new(url: BASE_URL) do |f|
      f.request :url_encoded
      f.response :json, parser_options: { symbolize_names: true }
      f.adapter Faraday.default_adapter
    end
  end

  def search_movies(query)
    response = @connection.get("search/movie") do |req|
      req.params["api_key"] = api_key
      req.params["query"] = query
      req.params["language"] = "ja-jp"
    end

    response.body[:results] || []
  end

  private

  def api_key
    ENV.fetch("TMDB_API_KEY")
  end
end
