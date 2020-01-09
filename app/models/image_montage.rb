require 'csv'

class ImageMontage < ApplicationRecord
  has_many :images
  has_one_attached :file

  scope :with_images, -> { includes(images: [:file_attachment, :file_blob]) }

  class << self
    def import_from_csv(file)
      CSV.foreach(file.path) do |row|
        GenerateMontageJob.perform_later(row)
      end
    end

    def export_as_csv
      CSV.generate do |csv_file|
        ImageMontage.find_each(batch_size: 100) do |image_montage|
          image_urls = image_montage.images.map(&:url)
          image_montage_url = Rails.application.routes.url_helpers.rails_blob_path(image_montage.file, only_path: true)
          csv_file << [*image_urls, image_montage_url]
        end
      end
    end
  end
end
