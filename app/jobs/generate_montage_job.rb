class GenerateMontageJob < ApplicationJob
  queue_as :default

  LOGO_FILENAME = 'generic_logo.png'.freeze
  LOGO_FILEPATH = Rails.root.join("public/#{LOGO_FILENAME}")

def perform(image_urls)
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
      montage << 'raw.jpg'
    end

    # Add logo watermark
    processed_image = MiniMagick::Image.open('raw.jpg')
    processed_image.combine_options do |c|
      c.gravity 'SouthEast'
      c.draw "image Over 0,0,0,0 \"#{LOGO_FILEPATH}\""
    end
    processed_image.write('montage.jpg')
    @montage.file.attach(io: File.open(processed_image.path), filename: 'montage.jpg')
    @montage.save!
  end
end
