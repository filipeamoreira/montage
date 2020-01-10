class GenerateMontageJob < ApplicationJob
  queue_as :default

  LOGO_FILENAME = 'generic_logo.png'.freeze
  LOGO_FILEPATH = Rails.root.join("public/#{LOGO_FILENAME}")

  def perform(image_urls)
    random_sufix = rand(0..100) # Add this to the temp file name to avoid collision
    # Create image records for each image url
    @montage = ImageMontage.new
    image_urls.each do |url|
      image = Image.new(url: url)
      temp_file = Down.download(url)
      image.file.attach(io: File.open(temp_file), filename: 'image.jpg')
      @montage.images << image
    end

    # Create montage
    MiniMagick::Tool::Montage.new do |montage|
      montage.geometry 'x700+0+0'
      @montage.images.each { |i| montage << i.url }
      montage << Rails.root.join("tmp/raw-#{random_sufix}.jpg")
    end

    # Add logo watermark
    processed_image = MiniMagick::Image.open(Rails.root.join("tmp/raw-#{random_sufix}.jpg"))
    processed_image.combine_options do |c|
      c.gravity 'SouthEast'
      c.draw "image Over 0,0,0,0 \"#{LOGO_FILEPATH}\""
    end
    processed_image.write(Rails.root.join("tmp/montage-#{random_sufix}.jpg"))
    @montage.file.attach(io: File.open(processed_image.path), filename: 'montage.jpg')
    @montage.save!
    cleanup_files(random_sufix)
  end

  private

  def cleanup_files(random_sufix)
    File.delete(Rails.root.join("tmp/raw-#{random_sufix}.jpg"))
    File.delete(Rails.root.join("tmp/montage-#{random_sufix}.jpg"))
  end
end
