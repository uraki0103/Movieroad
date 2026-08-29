class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: %i[show edit update]

  def index
    @records_by_year = current_user.records.includes(:movie, :theater).order(watched_day: :desc).group_by { |record| record.watched_day.year }
  end

  def new
    @record = current_user.records.new
  end

  def create
    @record = current_user.records.build(record_params)

    unless assign_movie(@record)
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
    unless assign_movie(@record)
      return render :edit, status: :unprocessable_entity
    end

    if @record.update(record_params)
      redirect_to records_path, notice: "記録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def assign_movie(record)
    if movie_title_param.blank?
      record.errors.add(:base, "映画タイトルを入力してください")
      return false
    end

    record.movie = Movie.find_or_create_by(title: movie_title_param)
  end

  def set_record
    @record = current_user.records.find(params[:id])
  end

  def movie_title_param
    params.dig(:record, :movie_title)
  end

  def record_params
    params.require(:record).permit(:rating, :watched_day)
  end
end
