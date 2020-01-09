class ImageMontagesController < ApplicationController
  def index
    @image_montages = ImageMontage
      .with_attached_file
      .with_images
      .all
      .page params[:page]
    @image_montage = ImageMontage.new
  end

  # Import CSV with image URLs
  def import
    ImageMontage.import_from_csv(image_montage_params[:file])

    redirect_to image_montages_url, notice: 'CSV import job has been processed. Jobs have started to run so please reload the page in a little while.'
  end

  # Export CSV with ImageMontages
  def export
    csv = ImageMontage.export_as_csv

    send_data csv, type: 'text/csv', filename: 'csv-export.csv'
  end

  def new
    @image_montage = ImageMontage.new
  end

  private
  def image_montage_params
    params.require(:image_montage).permit(:url, :file)
  end
end
