class TagsController < ApplicationController
  before_action :authenticate_user!

  def show
    @theaters = current_user.theaters.with_records_count.order(:theater_name)
    @companions = current_user.companions.with_records_count.order(:companion_name)
  end
end
