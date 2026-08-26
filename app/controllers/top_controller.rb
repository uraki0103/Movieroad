class TopController < ApplicationController
  def index
    redirect_to records_path if user_signed_in?
  end
end
