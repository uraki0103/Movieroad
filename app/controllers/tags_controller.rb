class TagsController < ApplicationController
  before_action :authenticate_user!

  def show
    @theaters = current_user.theaters.left_joins(:records).group(:id).order(:theater_name).select("theaters.*, COUNT(records.id) AS records_count")
    @companions = current_user.companions.left_joins(:records).group(:id).order(:companion_name).select("companions.*, COUNT(records.id) AS records_count")
  end
end
