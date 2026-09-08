class RecordMemoryPhotosController < ApplicationController
  before_action :authenticate_user!

  def destroy
    record = current_user.records.find(params[:record_id])
    @photo = record.memory_photos.find(params[:id])
    @photo.purge

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to edit_record_path(@record), notice: "写真を削除しました" }
    end
  end
end
