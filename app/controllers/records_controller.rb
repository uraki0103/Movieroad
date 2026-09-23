class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: %i[show edit update destroy]

  def index
    @records_by_year = current_user.records.includes(:movie, :theater, :companions, memory_photos_attachments: :blob)
                                            .order(watched_day: :desc)
                                            .group_by { |record| record.watched_day.year }
  end

  def new
    @record = current_user.records.new
  end

  def create
    @record = current_user.records.build(record_params)
    @submitted_companion_names = companion_names_param
    saved = false

    ActiveRecord::Base.transaction do
      assign_associations(@record)
      if @record.errors.blank? && @record.save
        saved = true
      else
        raise ActiveRecord::Rollback
      end
    end

    if saved
      redirect_to records_path, notice: "記録を保存しました"
    else
      @record.association(:companions).reload
      @submitted_companion_names = @record.companions.map(&:companion_name)
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @submitted_companion_names = companion_names_param
    saved = false

    ActiveRecord::Base.transaction do
      assign_associations(@record)

      if @record.errors.blank? && @record.update(record_params.except(:memory_photos))
        saved = true
      else
        raise ActiveRecord::Rollback
      end
    end

    if saved
      attach_memory_photos
      redirect_to records_path, notice: "記録を更新しました"
    else
      @record.association(:companions).reload
      @submitted_companion_names = @record.companions.map(&:companion_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path, notice: "記録を削除しました", status: :see_other
  end

  def search
    @q = current_user.records.ransack(params[:q])
    @records = @q.result(distinct: true).includes(:movie, :theater, :companions, memory_photos_attachments: :blob).order(watched_day: :desc)
  end

  private

  def assign_associations(record)
    assign_movie(record)
    assign_theater(record)
    assign_companions(record)
  end

  def assign_movie(record)
    if movie_title_param.blank?
      record.errors.add(:base, "映画タイトルを入力してください")
      return
    end

    movie = Movie.find_or_create_for(
      title: movie_title_param,
      tmdb_id: tmdb_id_param,
      release_year: release_year_param,
      poster_url: poster_url_param
    )

    if movie.persisted?
      record.movie = movie
    else
      record.errors.add(:base, "映画情報の保存に失敗しました")
    end
  end

  def assign_theater(record)
    if theater_name_param.blank?
      record.theater = nil
      return
    end

    theater = Theater.find_or_create_for(current_user, theater_name_param)

    if theater.persisted?
      record.theater = theater
    else
      record.errors.add(:base, "観賞場所の保存に失敗しました")
    end
  end

  def assign_companions(record)
    companions = Companion.find_or_create_all_for(current_user, companion_names_param)

    if companions.all?(&:persisted?)
      record.companions = companions
    else
      record.errors.add(:base, "観た人の保存に失敗しました")
    end
  end

  def attach_memory_photos
    photos = record_params[:memory_photos]&.reject(&:blank?)
    @record.memory_photos.attach(photos) if photos.present?
  end

  def set_record
    @record = current_user.records.find(params[:id])
  end

  def movie_title_param
    params.dig(:record, :movie_title)
  end

  def tmdb_id_param
    params.dig(:record, :tmdb_id).presence
  end

  def release_year_param
    params.dig(:record, :release_year).presence
  end

  def poster_url_param
    params.dig(:record, :poster_url).presence
  end

  def theater_name_param
    params.dig(:record, :theater_name)
  end

  def companion_names_param
    Array(params.dig(:record, :companion_names))
  end

  def record_params
    params.require(:record).permit(:rating, :watched_day, :impression, :memory_note, memory_photos: [])
  end
end
