class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @records_by_year = current_user.records.includes(:movie, :theater).order_by(:watched_day, :desc).group_by{ |record| record.watched_day.year }
  end

  def new
    @record = current_user.records.new
  end

  def create
    @record = current_user.records.build(record_params)

    Rails.logger.debug "movie_title_param = #{movie_title_param.inspect}"

    if movie_title_param.blank?
      @record.errors.add(:base, "映画タイトルを入力してください")
      return render :new, status: :unprocessable_entity
    end

    @record.movie = Movie.find_or_create_by(title: movie_title_param)

    if @record.save
      redirect_to records_path, notice: "記録を保存しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def movie_title_param
    params.dig(:record, :movie_title)
  end

  def record_params
    params.require(:record).permit(:rating, :watched_day)
  end
end
