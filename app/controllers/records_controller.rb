class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: %i[show edit update destroy]

  def index
    @records_by_year = current_user.records.includes(:movie, :theater).order(watched_day: :desc).group_by { |record| record.watched_day.year }
  end

  def new
    @record = current_user.records.new
  end

  def create
    @record = current_user.records.build(record_params)

    unless assign_movie(@record) && assign_theater(@record)
      return render :new, status: :unprocessable_entity
    end

    if @record.save
      redirect_to records_path, notice: "記録を保存しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    unless assign_movie(@record) && assign_theater(@record)
      return render :edit, status: :unprocessable_entity
    end

    if @record.update(record_params)
      redirect_to records_path, notice: "記録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path, notice: "記録を削除しました", status: :see_other
  end

  private

  def assign_movie(record)
    if movie_title_param.blank?
      record.errors.add(:base, "映画タイトルを入力してください")
      return false
    end

    movie = Movie.find_or_create_for(movie_title_param)

    unless movie.persisted?
      record.errors.add(:base, "映画情報の保存に失敗しました")
      return false
    end

    record.movie = movie
    true
  end

  def assign_theater(record)
      Rails.logger.debug "===== assign_theater START ====="
      Rails.logger.debug "theater_name_param: #{theater_name_param.inspect}"
    if theater_name_param.blank?
      Rails.logger.debug "===== theater_name is blank ====="
      record.theater = nil
      return true
    end

    theater = Theater.find_or_create_for(current_user, theater_name_param)

    unless theater.persisted?
      record.errors.add(:base, "観賞場所の保存に失敗しました")
      return false
    end

    record.theater = theater
    true
  end

  def set_record
    @record = current_user.records.find(params[:id])
  end

  def movie_title_param
    params.dig(:record, :movie_title)
  end

  def theater_name_param
    params.dig(:record, :theater_name)
  end

  def record_params
    params.require(:record).permit(:rating, :watched_day, :impression)
  end
end
