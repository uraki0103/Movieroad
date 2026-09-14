class MovieSearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:query].to_s.strip

    if @query.present?
      @results = Tmdb.new.search_movies(@query)
    else
      @results = []
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
