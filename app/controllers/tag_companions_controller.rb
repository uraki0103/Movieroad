class TagCompanionsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    companion = current_user.companions.find(params[:id])
    companion.destroy
    redirect_to tags_path, notice: "#{companion.companion_name}を削除しました"
  end
end
