class TagTheatersController < ApplicationController
  before_action :authenticate_user!
  def destroy
    theater = current_user.theaters.find(params[:id])
    result = theater.destroy

    redirect_to tags_path, notice: "#{theater.theater_name}を削除しました"
  end
end
